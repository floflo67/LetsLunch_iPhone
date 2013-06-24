//
//  CreateActivityViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "CreateActivityViewController.h"
#import "AppDelegate.h"
#import "NearbyVenuesViewController.h"

@interface CreateActivityViewController ()

@end

@implementation CreateActivityViewController

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

#pragma view lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Create";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                              target:self
                                              action:@selector(saveActivity:)];
    
    /*
     Change font and size of segmentControl's titles
     */
    UIFont *font = [UIFont boldSystemFontOfSize:16.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:UITextAttributeFont];
    [self.segment setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_map release];
    [_textFieldDescription release];
    [_segment release];
    [_buttonPushPlace release];
    [_labelBroadcast release];
    [_viewContent release];
    [super dealloc];
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
    
    self.viewContent.frame = CGRectMake(0, self.viewContent.frame.origin.y + height - 10, 320, self.viewContent.frame.size.height - height + 10);
    [self.view addSubview:self.map];
    [self.view sendSubviewToBack:self.map];
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

#pragma push select place

-(void)pushSelectPlace:(id)sender
{
    [self.navigationController pushViewController:[[NearbyVenuesViewController alloc] init] animated:YES];
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
    NSLog(@"Description: %@", self.textFieldDescription.text);
    
    NSString *time;
    if(self.segment.selectedSegmentIndex == 0)
        time = @" Now";
    else if (self.segment.selectedSegmentIndex == 1)
        time = @"Evening";
    else
        time = @"Now";
    
    NSLog(@"Type: %@", time);
    NSLog(@"Place: %@", [self.venue name]);
    NSLog(@"Save");
    [self.navigationController popToRootViewControllerAnimated:YES];
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
