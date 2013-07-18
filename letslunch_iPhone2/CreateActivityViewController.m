//
//  CreateActivityViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "CreateActivityViewController.h"
#import "NearbyVenuesViewController.h"
#import "ActivityViewController.h"

@interface CreateActivityViewController ()

@end

@implementation CreateActivityViewController

#pragma managing singleton

static CreateActivityViewController *sharedSingleton = nil;
+ (CreateActivityViewController*)getSingleton
{
    if (sharedSingleton != nil)
        return sharedSingleton;
    @synchronized(self)
    {
        if (sharedSingleton == nil)
            sharedSingleton = [[self alloc] init];
    }
    return sharedSingleton;
}

+ (void)suppressSingleton
{
    if (sharedSingleton != nil)
        sharedSingleton = nil;
}

#pragma view lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    _lunchRequest = [[LunchesRequest alloc] init];
    _lunchRequest.delegate = self;
    self.navigationItem.title = @"Create";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                              target:self
                                              action:@selector(saveActivity:)];
    
    /*
     Change font and size of segmentControl's titles
     */
    UIFont *font = [UIFont boldSystemFontOfSize:16.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:UITextAttributeFont];
    [self.segment setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    /*
     Clears background of table view
     */
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor clearColor];
}

/*
 Loads the view with an activity if existing
 */
-(void)loadViewWithActivity:(Activity*)activity
{
    if(activity) {
        /*
         Sets local variables
         */
        self.activity = activity;
        self.venue = activity.venue;
        
        /*
         Sets view
         */
        [self addMap:activity.venue];
        self.textFieldDescription.text = activity.description;
        if(activity.isCoffee)
            self.segment.selectedSegmentIndex = 0;
        else
            self.segment.selectedSegmentIndex = 1;
        
        /*
         Adding clear button
         */
        self.buttonClear = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.buttonClear addTarget:self action:@selector(clearBroadcast:) forControlEvents:UIControlEventTouchDown];
        self.buttonClear.frame = (CGRect){20, 5, 280, 40};
        [self.buttonClear setTitle:@"Clear broadcast" forState:UIControlStateNormal];
        [self.view addSubview:self.buttonClear];
        
        /*
         Changing frame of subview to leave place for clear button
         */
        self.viewSubview.frame = CGRectMake(0, self.viewSubview.frame.origin.y + 50, 320, self.viewSubview.frame.size.height - 50);
    }
    else
        return;
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    if(self.buttonClear)
       [self clearBroadcast:nil];
    else
        [self resetView];
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [self.venue release];
    [self.textFieldDescription release];
    [self.segment release];
    [self.labelBroadcast release];
    [self.viewContent release];
    [self.tableView release];
    [self.viewSubview release];
    [self.buttonClear release];
    [self.activity release];
    [self.map release];
    [super dealloc];
}

#pragma mark - Lunch request delegate

-(void)showErrorMessage:(NSString*)message withErrorStatus:(NSInteger)errorStatus
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NULL message:NULL delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alert.title = [NSString stringWithFormat:@"Error: %i", errorStatus];
    alert.message = message;
    [alert show];
    [alert release];
}

#pragma mapView

- (void)addMap:(FSVenue*)venue
{
    /*
     Sets the MKMapView
     No scroll, no zoom
     */
    int y = 110;
    int height = 150;
    if(!self.map)
        self.map = [[MKMapView alloc] initWithFrame:CGRectMake(0, y, self.view.frame.size.width, height)];
    self.map.zoomEnabled = self.map.scrollEnabled = NO;
    self.map.region = [self setupMapForLocation:venue.location];
    [self.map addAnnotations:[NSArray arrayWithObject:venue]];
    
    /*
     Moves view content
     */
    self.viewContent.frame = CGRectMake(0, self.viewContent.frame.origin.y + height - 25, 320, self.viewContent.frame.size.height);
    [self.viewSubview addSubview:self.map];
    [self.viewSubview sendSubviewToBack:self.map];
    
    /*
     Adding comment in description if no text
     Comment = "Meet me at [name]!"
     */
    if(self.textFieldDescription.text.length == 0) {
        self.textFieldDescription.text = [NSString stringWithFormat:@"Meet me at %@!", [self.venue name]];
    }
    
    [self.tableView reloadData];
}

- (MKCoordinateRegion)setupMapForLocation:(FSLocation*)newLocation
{
    /*
     Define size of zoom
     */
    MKCoordinateSpan span;
    span.latitudeDelta = 0.002;
    span.longitudeDelta = 0.002;
    
    /*
     Define origin
     Center = location of venue
     */
    CLLocationCoordinate2D location;
    location.latitude = newLocation.coordinate.latitude;
    location.longitude = newLocation.coordinate.longitude;
    
    MKCoordinateRegion region;
    region.span = span;
    region.center = location;
    return region;
}

- (void)resetView
{
    int height = 150;
    
    if(self.map) {
        [self.map removeAnnotations:[NSArray arrayWithObject:self.venue]];
        [self.map removeFromSuperview];
        self.map = nil;
        
        self.textFieldDescription.text = @"";
        self.venue = nil;
        self.viewContent.frame = CGRectMake(0, self.viewContent.frame.origin.y - height + 25, 320, self.viewContent.frame.size.height);
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(self.venue == nil) {
        cell.textLabel.text = @"Suggest a place";
        cell.detailTextLabel.text = @"optional";
    }
    else {
        cell.textLabel.text = [self.venue name];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[[self.venue location] address]];
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NearbyVenuesViewController *detailViewController = [[NearbyVenuesViewController alloc] init];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [self resetView];
    detailViewController = nil;
}

#pragma segment action

- (IBAction)segmentValueChanged:(id)sender
{
    UISegmentedControl *seg = (UISegmentedControl*)sender;
    
    if(seg.selectedSegmentIndex == 0)
        self.labelBroadcast.text = @"This broadcast will expire in 180 minutes.";
    else
        self.labelBroadcast.text = @"This broadcast will expire at 11:00 P.M.";
}

#pragma button click

- (void)saveActivity:(id)sender
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSString *description = self.textFieldDescription.text;
    if(self.activity && [description isEqualToString:@""]) {
        //delete
        [_lunchRequest suppressLunchWithToken:[AppDelegate getObjectFromKeychainForKey:kSecAttrAccount] andActivityID:self.activity.activityID];
        app.ownerActivity = nil;
    }
    else if(!self.activity && [description isEqualToString:@""]) {
        
    }
    else {
        //add        
        Activity *activity = [[Activity alloc] init];
        activity.description = description;
        activity.isCoffee = self.segment.selectedSegmentIndex;
        activity.venue = self.venue;
        if(app.ownerActivity) {
            app.ownerActivity = nil;
            [[ActivityViewController getSingleton] loadOwnerActivity];
        }
        else {
            [_lunchRequest addLunchWithToken:[AppDelegate getObjectFromKeychainForKey:kSecAttrAccount] andActivity:activity];
        }
        app.ownerActivity = activity;
    }
    if(self.activity)
        [self.activity release];
    
    [[ActivityViewController getSingleton] loadOwnerActivity];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [CreateActivityViewController suppressSingleton];
}

- (void)clearBroadcast:(id)sender
{
    self.buttonClear.hidden = YES;
    self.buttonClear = nil;
    self.viewSubview.frame = CGRectMake(0, self.viewSubview.frame.origin.y - 50, 320, self.viewSubview.frame.size.height + 50);
    [self resetView];
}

#pragma UITextFieldDelegate

- (IBAction)textFieldReturn:(id)sender
{
    [self textFieldShouldReturn:sender];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

@end



#pragma custom TextField

@interface MYTextField : UITextField

@end

@implementation MYTextField

- (CGRect)textRectForBounds:(CGRect)bounds
{
    int margin = 10;
    CGRect inset = CGRectMake(bounds.origin.x + margin, bounds.origin.y + margin, bounds.size.width - margin, bounds.size.height - margin);
    return inset;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    int margin = 10;
    CGRect inset = CGRectMake(bounds.origin.x + margin, bounds.origin.y + margin, bounds.size.width - margin, bounds.size.height - margin);
    return inset;
}

@end