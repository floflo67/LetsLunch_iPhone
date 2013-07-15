//
//  CenterViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "CenterViewController.h"
#import "CenterViewControllerImportFile.h"

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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenuLeft.png"]
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                            action:@selector(revealLeftSidebar:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenuRight.png"]
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(revealRightSidebar:)];
    
    self.navigationItem.revealSidebarDelegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc
{    
    [self.leftSelectedIndexPath release];
    [self.leftSidebarViewController release];
    [self.rightSidebarViewController release];
    [self.centerView release];
    [super dealloc];
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
    [self.centerView addSubview:[ContactViewController getSingleton].view];
    self.navigationItem.title = @"Contact";
}

- (void)FriendConfiguration
{
    self.centerView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    [self.centerView addSubview:[FriendsViewController getSingleton].view];
    self.navigationItem.title = @"Friend";
}

- (void)ProfileConfiguration
{
    self.centerView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    [self.centerView addSubview:[ProfileViewController getSingleton].view];
    self.navigationItem.title = @"Profile";
}

- (void)logout
{
    [AppDelegate logout];
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
    [self.navigationController pushViewController:[CreateActivityViewController getSingleton] animated:YES];
    if(sender)
       [[CreateActivityViewController getSingleton] loadViewWithActivity:sender];
}

# pragma friends

- (void)findFriendsButtonClick:(id)sender
{
    NSLog(@"Find");
    [self.navigationController toggleRevealState:JTRevealedStateNo];
}

- (void)inviteFriendsButtonClick:(id)sender
{
    [self.navigationController toggleRevealState:JTRevealedStateNo];
    InviteViewController *invite = [[InviteViewController alloc] init];
    [self.navigationController pushViewController:invite animated:YES];
}

- (void)shareButtonClick:(id)sender
{
    ShareViewController *shareVC = [ShareViewController getSingleton];
    [shareVC.view setFrame:[[UIScreen mainScreen] bounds]];
    [self.navigationController.view addSubview:shareVC.view];
    [self.navigationController toggleRevealState:JTRevealedStateNo];
}

- (void)closeView:(id)sender
{
    [[ShareViewController getSingleton].view removeFromSuperview];
    [ShareViewController suppressSingleton];
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

// This is an examle to configure your sidebar view through a custom UITableViewController
- (UIView *)viewForLeftSidebar {
    CGRect viewFrame = self.navigationController.applicationViewFrame;
    UITableViewController *controller = self.leftSidebarViewController;
    if (!controller) {
        self.leftSidebarViewController = [[LeftSidebarViewController alloc] initWithStyle:UITableViewStylePlain];
        self.leftSidebarViewController.tableView.scrollEnabled = NO;
        
        UIColor *color = [UIColor colorWithPatternImage:[AppDelegate imageWithImage:[UIImage imageNamed:@"BackgroundMenu.png"]
                                                                       scaledToSize:CGSizeMake(277, 900)]];
        self.leftSidebarViewController.view.backgroundColor = color;
        
        
        self.leftSidebarViewController.sidebarDelegate = self;
        self.leftSidebarViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        controller = self.leftSidebarViewController;
    }
    controller.view.frame = CGRectMake(0, viewFrame.origin.y - 5, 270, viewFrame.size.height + 5);
    //controller.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    return controller.view;
}

// This is an examle to configure your sidebar view without a UIViewController
- (UIView *)viewForRightSidebar {
    CGRect viewFrame = self.navigationController.applicationViewFrame;
    UITableViewController *controller = self.rightSidebarViewController;
    if (!controller) {
        self.rightSidebarViewController = [[RightSidebarViewController alloc] initWithStyle:UITableViewStylePlain];
        self.rightSidebarViewController.tableView.scrollEnabled = NO;
        
        /*
         Used http://imagecolorpicker.com/ and https://kuler.adobe.com/create/color-wheel/ to get color for background
         */
        self.rightSidebarViewController.tableView.backgroundColor = [AppDelegate colorWithHexString:@"3C332A"];
        
        //self.rightSidebarViewController.sidebarDelegate = self;
        self.rightSidebarViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        controller = self.rightSidebarViewController;
    }
    
    controller.view.frame = CGRectMake(0, viewFrame.origin.y - 5, 270, viewFrame.size.height + 5);
    //controller.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
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
    if([[object description] isEqualToString:@"Messages"])
        [self MessageConfiguration];
    if([[object description] isEqualToString:@"Friends"])
        [self FriendConfiguration];
    if([[object description] isEqualToString:@"Profile"])
        [self ProfileConfiguration];
    if([[object description] isEqualToString:@"Logout"])
        [self logout];
}

- (NSIndexPath *)lastSelectedIndexPathForSidebarViewController:(LeftSidebarViewController *)sidebarViewController {
    return self.leftSelectedIndexPath;
}

@end