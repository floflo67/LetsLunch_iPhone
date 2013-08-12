//
//  ActivityViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "ActivityViewController.h"
#import "DetailProfileViewController.h"
#import "ActivityCell.h"

@interface ActivityViewController ()
@property (nonatomic, strong) NSMutableArray* objects;
@property (nonatomic, strong) UIButton *pushButton;
@property (nonatomic) BOOL hasActivity;
@end

@implementation ActivityViewController

static ActivityViewController *sharedSingleton = nil;
+ (ActivityViewController*)getSingleton
{
    if (sharedSingleton != nil) {
        [sharedSingleton.tableView reloadData];
        return sharedSingleton;
    }
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [AppDelegate colorWithHexString:@"f0f0f0"];
    
    [self loadOwnerActivity];
    [self loadListActivites];
    
    [self setTextLoading:@"Loading..." textRelease:@"Release to refresh..." andTextPull:@"Pull down to refresh..."];
    [self.tableView reloadData];
}

#pragma mark - API call

- (void)loadOwnerActivity
{
    /*
     If activity exists -> populate with activity
     If not -> populate with @"NIL"
     */
    AppDelegate* app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if([app getOwnerActivityAndForceReload:NO]) {
        self.objects[0] = [app getOwnerActivityAndForceReload:NO];
        self.hasActivity = YES;
    }
    else {
        self.objects[0] = @"NIL";
        self.hasActivity = NO;
    }
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)loadListActivites
{
    /*
     If activities exists -> populate with activities
     If not -> populate with @"NIL"
     */
    AppDelegate* app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if([app getListActivitiesAndForceReload:YES])
        self.objects[1] = [app getListActivitiesAndForceReload:NO];
    else
        self.objects[1] = @"NIL";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 1;
    else if([[self.objects[section] description] isEqualToString:@"NIL"])
        return 0;
    else
        return [self.objects[section] count];
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    /*
     Height 44 if no activity
     Height 120 if activity
     */
    if([[self.objects[indexPath.section] description] isEqualToString:@"NIL"])
        return 44.0f;
    else
        return 120.0f;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *CellIdentifier = @"ActivityCell";
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ActivityCell" owner:self options:nil];
        cell = topLevelObjects[0]; // Sets cell as ActivityCell
    }
    
    
    if(indexPath.section == 1) { // Activities around
        [cell showView];
        [cell loadTextColor];
        Activity *activity = self.objects[indexPath.section][indexPath.row];
        
        [cell setUserName:[NSString stringWithFormat:@"%@ %@ - %@", activity.contact.firstname, activity.contact.lastname, activity.contact.jobTitle] jobTitle:activity.description venueName:activity.venue.name time:activity.time andPicture:activity.contact.image];
    }
    else { // Owner
        if([[self.objects[indexPath.section] description] isEqualToString:@"NIL"]) { // No activity
            
            /*
             Creates push button
             */
            [self.pushButton addTarget:self action:@selector(pushViewController:) forControlEvents:UIControlEventTouchDown];
            
            [cell hideView];            
            [self.pushButton setBackgroundImage:[UIImage imageNamed:@"buttonBroadcastAvailability"] forState:UIControlStateNormal];
            self.pushButton.enabled = YES;
            
            if(!((AppDelegate*)[UIApplication sharedApplication].delegate).hasEnableGPS) {
                [AppDelegate showErrorMessage:@"Please enable GPS in settings" withErrorStatus:500];
                self.pushButton.enabled = NO;
            }
            [cell addSubview:self.pushButton];
        }
        else { // Activity
            [cell showView];
            [cell loadTextColor];
            Activity *activity = self.objects[indexPath.section];
            
            [cell setUserName:[NSString stringWithFormat:@"%@ %@ - %@", activity.contact.firstname, activity.contact.lastname, activity.contact.jobTitle] jobTitle:activity.description venueName:activity.venue.name time:activity.time andPicture:activity.contact.image];
        }
    }
    
    return cell;
}

- (void)pushViewController:(id)sender
{
    CenterViewController* center = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).viewController;
    if([sender class] == [UIButton class])
        [center pushCreateActivityViewController:nil];
    else if([sender class] == [Activity class])
        [center pushCreateActivityViewController:sender];
    
}

#pragma mark - Table view reload

/*
 Functions from PullRefreshTableViewController
 */
- (void)refresh
{
    [self loadListActivites];
    [self performSelector:@selector(reloadUI) withObject:nil afterDelay:2.0];
}

- (void)reloadUI
{
    [self.tableView reloadData];
    [self stopLoading];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    if(indexPath.section == 1) {
        Activity *activity = _objects[indexPath.section][indexPath.row];
        DetailProfileViewController *detail = [[DetailProfileViewController alloc] initWithContactID:activity.contact.ID];
        [((AppDelegate*)[UIApplication sharedApplication].delegate).viewController.navigationController pushViewController:detail animated:YES];
        detail = nil;
    }
    else if(![[self.objects[indexPath.section] description] isEqualToString:@"NIL"]) {
        Activity* act = (Activity*)self.objects[indexPath.row];
        [self pushViewController:act];
    }
}

#pragma mark - getter and setter

- (NSMutableArray*)objects
{
    if(!_objects)
        _objects = [[NSMutableArray alloc] init];
    return _objects;
}

- (UIButton *)pushButton
{
    if(!_pushButton) {
        _pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _pushButton.frame = (CGRect){0, -3, 320, 51};
    }
    return _pushButton;
}

@end
