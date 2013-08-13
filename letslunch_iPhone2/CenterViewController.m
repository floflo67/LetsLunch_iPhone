//
//  CenterViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "CenterViewController.h"
#import "CenterViewControllerImportFile.h"

@interface CenterViewController() <UITableViewDataSource, UITableViewDelegate, LeftSidebarViewControllerDelegate>

@property (nonatomic, strong) LeftSidebarViewController *leftSidebarViewController;
@property (nonatomic, strong) RightSidebarViewController *rightSidebarViewController;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) NSIndexPath *leftSelectedIndexPath;
@end

@implementation CenterViewController


#pragma mark - view lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    [self.view addSubview:self.centerView];
    
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

#pragma mark - configuration

- (void)ActivityConfiguration
{
    self.centerView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    [self.centerView addSubview:[ActivityViewController getSingleton].view];
    self.navigationItem.title = @"Activity";
}

- (void)MessageConfiguration
{
    if([ContactViewController getSingleton]) {
        [self removeSuperviews];
        self.centerView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        [self.centerView addSubview:[ContactViewController getSingleton].view];
        self.navigationItem.title = @"Contact";
    }
}

- (void)ProfileConfiguration
{
    if([ProfileViewController getSingleton]) {
        [self removeSuperviews];
        self.centerView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        [self.centerView addSubview:[ProfileViewController getSingleton].view];
        self.navigationItem.title = @"Profile";
    }
}

- (void)VisitorsConfiguration
{
    self.centerView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    [self.centerView addSubview:[VisitorsViewController getSingleton].view];
    self.navigationItem.title = @"Visitors";
}

- (void)AddLunchersConfiguration
{
    self.centerView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    [self.centerView addSubview:[InviteViewController getSingleton].view];
    self.navigationItem.title = @"Invite";
}

- (void)removeSuperviews
{
    if([self.centerView.subviews count] > 0) {
        for (UIView* v in self.centerView.subviews) {
            [v removeFromSuperview];
        }
    }
}

- (void)logout
{
    [AppDelegate logout];
}

#pragma mark - reveal side bars

- (void)revealLeftSidebar:(id)sender
{
    [self.navigationController toggleRevealState:JTRevealedStateLeft];
}

- (void)revealRightSidebar:(id)sender
{
    [self.navigationController toggleRevealState:JTRevealedStateRight];
}

#pragma mark - activity

- (void)pushCreateActivityViewController:(id)sender
{
    [self.navigationController pushViewController:[CreateActivityViewController getSingleton] animated:YES];
    if(sender)
       [[CreateActivityViewController getSingleton] loadViewWithActivity:sender];
}

# pragma friends

- (void)findFriendsButtonClick:(id)sender
{
    [self.navigationController toggleRevealState:JTRevealedStateNo];
}

- (void)shareButtonClick:(id)sender
{
    ShareViewController *shareVC = [ShareViewController getSingleton];
    [shareVC.view setFrame:[[UIScreen mainScreen] bounds]];
    [self.navigationController.view addSubview:shareVC.view];
    [self.navigationController toggleRevealState:JTRevealedStateNo];
}

- (void)closeView
{
    [[ShareViewController getSingleton].view removeFromSuperview];
    [ShareViewController suppressSingleton];
}

#pragma mark - JTRevealSidebarDelegate

// This is an examle to configure your sidebar view through a custom UITableViewController
- (UIView*)viewForLeftSidebar
{
    CGRect viewFrame = self.navigationController.applicationViewFrame;
    
    UIColor *color = [UIColor colorWithPatternImage:[AppDelegate imageWithImage:[UIImage imageNamed:@"BackgroundMenu.png"] scaledToSize:CGSizeMake(277, 900)]];
    self.leftSidebarViewController.view.backgroundColor = color;
    self.leftSidebarViewController.sidebarDelegate = self;
        
    UITableViewController *controller = self.leftSidebarViewController;
    controller.view.frame = CGRectMake(0, viewFrame.origin.y - 5, 270, viewFrame.size.height + 5);
    
    return controller.view;
}

// This is an examle to configure your sidebar view without a UIViewController
- (UIView*)viewForRightSidebar
{
    CGRect viewFrame = self.navigationController.applicationViewFrame;
    
    /*
     Used http://imagecolorpicker.com/ and https://kuler.adobe.com/create/color-wheel/ to get color for background
     */
    self.rightSidebarViewController.tableView.backgroundColor = [AppDelegate colorWithHexString:@"3C332A"];
    
    UITableViewController *controller = self.rightSidebarViewController;
    controller.view.frame = CGRectMake(0, viewFrame.origin.y - 5, 270, viewFrame.size.height + 5);
    
    return controller.view;
}

// Optional delegate methods for additional configuration after reveal state changed
- (void)didChangeRevealedStateForViewController:(UIViewController*)viewController
{
    if (viewController.revealedState == JTRevealedStateNo) {
        self.view.userInteractionEnabled = YES;
    } else {
        self.view.userInteractionEnabled = NO;
    }
}

#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( ! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    return cell;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.rightSidebarViewController.view) {
        return @"RightSidebar";
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [self.navigationController setRevealedState:JTRevealedStateNo];
    if (tableView == self.rightSidebarViewController.view) {
        //NSLog([NSString stringWithFormat:@"Selected %d at RightSidebarView", indexPath.row]);
    }
}

#pragma mark - SidebarViewControllerDelegate

- (void)sidebarViewController:(LeftSidebarViewController*)sidebarViewController didSelectObject:(NSObject*)object atIndexPath:(NSIndexPath*)indexPath
{
    [self.navigationController setRevealedState:JTRevealedStateNo];
    
    if([[object description] isEqualToString:@"Activity"])
        [self ActivityConfiguration];
    if([[object description] isEqualToString:@"Messages"])
        [self MessageConfiguration];
    if([[object description] isEqualToString:@"Profile"])
        [self ProfileConfiguration];
    if([[object description] isEqualToString:@"Visitors"])
       [self VisitorsConfiguration];
    if([[object description] isEqualToString:@"Add lunchers"])
       [self AddLunchersConfiguration];
    if([[object description] isEqualToString:@"Logout"])
        [self logout];
}

- (NSIndexPath*)lastSelectedIndexPathForSidebarViewController:(LeftSidebarViewController*)sidebarViewController
{
    return self.leftSelectedIndexPath;
}

#pragma mark - getter and setter

- (LeftSidebarViewController*)leftSidebarViewController
{
    if(!_leftSidebarViewController) {
        _leftSidebarViewController = [[LeftSidebarViewController alloc] initWithStyle: UITableViewStylePlain];
        _leftSidebarViewController.tableView.scrollEnabled = NO;
        _leftSidebarViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _leftSidebarViewController;
}

- (RightSidebarViewController *)rightSidebarViewController
{
    if(!_rightSidebarViewController) {
        _rightSidebarViewController = [[RightSidebarViewController alloc] initWithStyle:UITableViewStylePlain];
        _rightSidebarViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightSidebarViewController.tableView.scrollEnabled = NO;
    }
    return _rightSidebarViewController;
}

- (UIView *)centerView
{
    if(!_centerView)
        _centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    return _centerView;
}

@end