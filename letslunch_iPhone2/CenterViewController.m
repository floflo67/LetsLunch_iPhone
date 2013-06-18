//
//  CenterViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "CenterViewController.h"
#import "UIViewController+JTRevealSidebarV2.h"
#import "UINavigationItem+JTRevealSidebarV2.h"
#import "LeftSidebarViewController.h"
#import "NewViewController.h"
#import "JTRevealSidebarV2Delegate.h"
#import "ActivityViewController.h"
#import "MessageViewController.h"	
#import "FriendsViewController.h"
#import "CreateActivityViewController.h"
#import "AppDelegate.h"

@interface CenterViewController (Private) <UITableViewDataSource, UITableViewDelegate, LeftSidebarViewControllerDelegate>
@end

@implementation CenterViewController

@synthesize leftSidebarViewController;
@synthesize rightSidebarViewController;
@synthesize centerView;
@synthesize leftSelectedIndexPath;


#pragma view lifecycle

- (id)init {
    self = [super init];
    if(self) {
        [self locationManagerInit];
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    self.centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.centerView];
    [self ActivityConfiguration];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu.png"]
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                            action:@selector(revealLeftSidebar:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize
                                                                                           target:self
                                                                                           action:@selector(revealRightSidebar:)];

    self.navigationItem.revealSidebarDelegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.rightSidebarViewController = nil;
}

#pragma configuration

- (void)ActivityConfiguration
{
    self.centerView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    [self.centerView addSubview:[ActivityViewController getSingleton].view];
    self.navigationItem.title = @"Activity";
}

- (void)MessageConfiguration
{
    self.centerView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    [self.centerView addSubview:[MessageViewController getSingleton].view];
    self.navigationItem.title = @"Message";
}

- (void)FriendConfiguration
{
    self.centerView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    [self.centerView addSubview:[FriendsViewController getSingleton].view];
    self.navigationItem.title = @"Friend";    
}

#pragma reveal side bars

- (void)revealLeftSidebar:(id)sender
{
    [self.navigationController toggleRevealState:JTRevealedStateLeft];
}

- (void)revealRightSidebar:(id)sender
{
    [self.navigationController toggleRevealState:JTRevealedStateRight];
}

#pragma activity

- (void)pushCreateActivityViewController:(id)sender
{
    QRootElement *root = [[QRootElement alloc] init];
    root.title = @"Create Activity";
    root.grouped = YES;
    QSection *section = [[QSection alloc] init];
    _description = [[QEntryElement alloc] initWithTitle:@"Description" Value:@"" Placeholder:@"Enter description"];
    [locationManager stopUpdatingLocation];
    _date = [[QDateTimeInlineElement alloc] initWithTitle:@"Time today" date:[NSDate new] andMode:UIDatePickerModeTime];
    _date.minuteInterval = 15;
    _radio = [[QRadioSection alloc] initWithItems:[NSArray arrayWithObjects:@"Coffee", @"Lunch", nil] selected:0 title:@"Type"];
    
    [root addSection:section];
    [section addElement:_description];
    [section addElement:_date];
    [root addSection:_radio];
    
    UIViewController *navigation = [QuickDialogController controllerForRoot:root];
    [self.navigationController pushViewController:navigation animated:YES];
    navigation.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveActivity:)];
}

- (void)saveActivity:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSLog(@"Description: %@", _description.textValue);
    
    /*
     Convert _date.dateValue which is UTC/GMT to local time
     */
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"MM/dd/YYYY H:mm:ss Z"]; // format US: Month/Day/Year Hours:Minutes:Seconds (0 < Hour <= 12)
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:[[NSTimeZone localTimeZone] abbreviation]]];    
    NSLog(@"%@", [dateFormatter stringFromDate:_date.dateValue]);
    
    NSLog(@"Radio: %@", [_radio.selectedItems lastObject]);
    NSLog(@"Save");
}

#pragma location

- (void)locationManagerInit
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //[locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    NSLog(@"lat%f - lon%f", location.coordinate.latitude, location.coordinate.longitude);
}

#pragma mark JTRevealSidebarDelegate

// This is an examle to configure your sidebar view through a custom UIViewController
- (UIView *)viewForLeftSidebar {
    CGRect viewFrame = self.navigationController.applicationViewFrame;
    UITableViewController *controller = self.leftSidebarViewController;
    if (!controller) {
        self.leftSidebarViewController = [[LeftSidebarViewController alloc] initWithStyle:UITableViewStylePlain];
        self.leftSidebarViewController.tableView.scrollEnabled = NO;
        self.leftSidebarViewController.view.backgroundColor = [AppDelegate colorWithHexString:@"183060"];
        self.leftSidebarViewController.sidebarDelegate = self;
        self.leftSidebarViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        controller = self.leftSidebarViewController;
    }
    controller.view.frame = CGRectMake(0, viewFrame.origin.y - 5, 270, viewFrame.size.height + 5);
    controller.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    return controller.view;
}

// This is an examle to configure your sidebar view without a UIViewController
- (UIView *)viewForRightSidebar {
    CGRect viewFrame = self.navigationController.applicationViewFrame;
    UITableViewController *controller = self.rightSidebarViewController;
    if (!controller) {
        self.rightSidebarViewController = [[RightSidebarViewController alloc] initWithStyle:UITableViewStylePlain];
        //self.rightSidebarViewController.view.backgroundColor = [AppDelegate colorWithHexString:@"183060"];
        //self.rightSidebarViewController.sidebarDelegate = self;
        self.rightSidebarViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        controller = self.rightSidebarViewController;
    }
    
    controller.view.frame = CGRectMake(self.navigationController.view.frame.size.width - 270, viewFrame.origin.y, 270, viewFrame.size.height);
    controller.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    return controller.view;
}

// Optional delegate methods for additional configuration after reveal state changed
- (void)didChangeRevealedStateForViewController:(UIViewController *)viewController {
    if (viewController.revealedState == JTRevealedStateNo) {
        self.view.userInteractionEnabled = YES;
    } else {
        self.view.userInteractionEnabled = NO;
    }
}

@end


@implementation CenterViewController (Private)

#pragma mark UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( ! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.rightSidebarViewController.view) {
        return @"RightSidebar";
    }
    return nil;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController setRevealedState:JTRevealedStateNo];
    if (tableView == self.rightSidebarViewController.view) {
        //NSLog([NSString stringWithFormat:@"Selected %d at RightSidebarView", indexPath.row]);
    }
}

#pragma mark SidebarViewControllerDelegate

- (void)sidebarViewController:(LeftSidebarViewController *)sidebarViewController didSelectObject:(NSObject*)object atIndexPath:(NSIndexPath *)indexPath
{

    [self.navigationController setRevealedState:JTRevealedStateNo];
    
    if([self.centerView.subviews count] > 0) {
        for (UIView* v in self.centerView.subviews) {
            [v removeFromSuperview];
        }
    }
    
    if([[object description] isEqualToString:@"Activity"])
        [self ActivityConfiguration];
    if([[object description] isEqualToString:@"Message"])
        [self MessageConfiguration];
    if([[object description] isEqualToString:@"Friends"])
        [self FriendConfiguration];
}

- (NSIndexPath *)lastSelectedIndexPathForSidebarViewController:(LeftSidebarViewController *)sidebarViewController {
    return self.leftSelectedIndexPath;
}

@end