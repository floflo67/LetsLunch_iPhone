//
//  ActivityViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "ActivityViewController.h"
#import "DetailProfileViewController.h"

@interface ActivityViewController ()

@end

@implementation ActivityViewController
@synthesize lunchRequest;

static ActivityViewController *sharedSingleton = nil;
+ (ActivityViewController*)getSingleton
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.lunchRequest = [[LunchesRequest alloc] init];
    self.lunchRequest.delegate = self;
    
    if(!_objects) {
        AppDelegate* app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        _objects = [[NSMutableArray alloc] init];
        
        if([app getOwnerActivityAndForceReload:NO]) {
            _objects[0] = [app getOwnerActivityAndForceReload:NO];
            self.hasActivity = YES;
        }
        else {
            _objects[0] = @"NIL";
            self.hasActivity = NO;
        }
        
        _objects[1] = [app getListActivitiesAndForceReload:NO];
    }
    
    [self.tableView reloadData];
}

- (void)loadOwnerActivity
{
    AppDelegate* app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [_objects[0] release];
    if([app getOwnerActivityAndForceReload:NO]) {
        _objects[0] = [app getOwnerActivityAndForceReload:NO];
        self.hasActivity = YES;
    }
    else {
        _objects[0] = @"NIL";
        self.hasActivity = NO;
    }
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [self.objects release];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 1;
    else
        return [_objects[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if(indexPath.section == 1) {
        NSArray *object = _objects[indexPath.section];
        cell.textLabel.text = [object[indexPath.row] description];
    }
    else {
        if([[_objects[indexPath.section] description] isEqualToString:@"NIL"]) {
            NSLog(@"nil");
            UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [pushButton addTarget:self
                           action:@selector(pushViewController:)
                 forControlEvents:UIControlEventTouchDown];
            pushButton.frame = (CGRect){0, - 3, 320, 51};
            pushButton.tag = 50;
            
            [pushButton setBackgroundImage:[UIImage imageNamed:@"buttonBroadcastAvailability"] forState:UIControlStateNormal];
            [cell addSubview:pushButton];
        }
        else {
            NSLog(@"exists");
            cell.textLabel.text = [_objects[indexPath.row] description];
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1) {
        DetailProfileViewController *detail = [[[DetailProfileViewController alloc] init] autorelease];
        [((AppDelegate*)[UIApplication sharedApplication].delegate).viewController.navigationController pushViewController:detail animated:YES];
        detail = nil;
    }
    else if(![[_objects[indexPath.section] description] isEqualToString:@"NIL"]) {
        Activity* act = (Activity*)_objects[indexPath.row];
        [self pushViewController:act];
    }
}

@end
