//
//  NearbyVenuesViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 20/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "NearbyVenuesViewController.h"
#import "Foursquare2.h"
#import "FSVenue.h"
#import "FSConverter.h"
#import "CreateActivityViewController.h"

@interface NearbyVenuesViewController ()

@end

@implementation NearbyVenuesViewController

#pragma view life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.isSearching = NO;
    self.section = @"food"; // default
    self.query = nil;
    self.radius = @(500); // 500m
    self.navigationItem.title = @"Place";
    
    /*
     To get current location
     */
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
    
    /*
     Add rightButton on navigationBar to search
     */
    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search:)];
    search.style = UIBarButtonItemStylePlain;
    self.navigationItem.rightBarButtonItem = search;
    search = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma button event

- (void)search:(id)sender
{
    int y = 40;
    /*
     Removes textField
     Moves segmentControl and TableView back up
     */
    if(self.isSearching) {
        self.isSearching = NO;
        self.segment.frame = CGRectMake(0, self.segment.frame.origin.y - y, self.segment.frame.size.width, self.segment.frame.size.height);
        self.tableView.frame = CGRectMake(0, self.tableView.frame.origin.y - y, self.tableView.frame.size.width, self.tableView.frame.size.height);
        self.textFieldSearch.hidden = YES;
        [self.textFieldSearch removeFromSuperview];
        self.textFieldSearch = nil;
    }
    /*
     Adds textField
     Moves segmentControl and TableView down
     */
    else {
        self.isSearching = YES;
        self.segment.frame = CGRectMake(0, self.segment.frame.origin.y + y, self.segment.frame.size.width, self.segment.frame.size.height);
        self.tableView.frame = CGRectMake(0, self.tableView.frame.origin.y + y, self.tableView.frame.size.width, self.tableView.frame.size.height);
        self.textFieldSearch = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, self.view.frame.size.width - 10, y - 10)];
        self.textFieldSearch.delegate = self;
        self.textFieldSearch.placeholder = @"Search for a place or an office...";
        [self.textFieldSearch setBorderStyle:UITextBorderStyleRoundedRect];
        self.textFieldSearch.returnKeyType = UIReturnKeySearch;
        [self.view addSubview:self.textFieldSearch];
    }
}

/*
 Depending on segment
 Radius reset to 500m
 */
- (IBAction)valueChanged:(id)sender
{
    UISegmentedControl *seg = (UISegmentedControl*)sender;
    self.radius = @(500);
    switch (seg.selectedSegmentIndex) {
        case 0:
            self.section = @"food";
            break;
        case 1:
            self.section = @"coffee";
            break;
        case 2:
            self.section = @"specials";
            break;
        default:
            self.section = @"food";
            break;
    }
    if(self.isSearching)
        [self search:nil];
    [self getVenuesForLocation:_locationManager.location];
}

#pragma text field delegates

/*
 When user presses return key (search)
 Updates view with search
 Calls search to remove textField and move segmentControl and TableView up
 Radius bigger to show more results (10km)
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.section = nil;
    self.query = textField.text;
    self.radius = @(10000);
    [self search:nil];
    [self getVenuesForLocation:_locationManager.location];
    self.segment.selectedSegmentIndex = UISegmentedControlNoSegment;
    
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nearbyVenues.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.nearbyVenues.count) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [self.nearbyVenues[indexPath.row] name];
    FSVenue *venue = self.nearbyVenues[indexPath.row];
    if (venue.location.address) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@m, %@", venue.location.distance, venue.location.address];
    }
    else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@m", venue.location.distance];
    }
    return cell;
}

-(void)getVenuesForLocation:(CLLocation*)location
{
    self.nearbyVenues = nil;
    self.nearbyVenues = [[NSMutableArray alloc] init];
    
    [Foursquare2 searchVenuesNearByLatitude:@(location.coordinate.latitude)
								  longitude:@(location.coordinate.longitude)
                                    section:self.section
									  query:self.query
									 intent:intentBrowse
                                     radius:self.radius
								   callback:^(BOOL success, id result) {
									   if (success) {
										   NSDictionary *dic = result;
                                           NSArray* venues;
                                           if(self.section)
                                               venues = [dic valueForKeyPath:@"response.groups.items.venue"];
                                           else
                                               venues = [dic valueForKeyPath:@"response.venues"];
                                           
                                           FSConverter *converter = [[FSConverter alloc] init];
                                           self.nearbyVenues = [converter convertToObjects:venues];
                                           /*
                                            self.nearby count == 0 ==> no result
                                            */
                                           if([self.nearbyVenues count] > 0)
                                               [self.tableView insertSections:[NSIndexSet indexSetWithIndex:0]
                                                             withRowAnimation:UITableViewRowAnimationNone];
                                           else {
                                               UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                              message:@"No place found"
                                                                                             delegate:nil
                                                                                    cancelButtonTitle:@"OK"
                                                                                    otherButtonTitles:nil];
                                               [view show];
                                               view = nil;
                                           }
									   }
								   }];
    [self.tableView reloadData];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [_locationManager stopUpdatingLocation];
    [self getVenuesForLocation:newLocation];
}

#pragma mark - Table view delegate

/*
 Goes back to createActivity
 */
-(void)userDidSelectVenue
{
    [CreateActivityViewController getSingleton].venue = self.selected;
    [[CreateActivityViewController getSingleton] addMap:self.selected];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selected = self.nearbyVenues[indexPath.row];
    [self userDidSelectVenue];
}

@end
