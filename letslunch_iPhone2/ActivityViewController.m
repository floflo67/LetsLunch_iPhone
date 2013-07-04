//
//  ActivityViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "ActivityViewController.h"
#import "AppDelegate.h"
#import "DetailProfileViewController.h"
#import "AppDelegate.h"

@interface ActivityViewController ()

@end

@implementation ActivityViewController

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

-(id)init
{
    self = [super init];
    if(!_objects) {
        AppDelegate* app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        _objects = [[NSMutableArray alloc] initWithArray:[app getListActivitiesAndForceReload:NO]];
        
        if([app getOwnerActivityAndForceReload:NO]) {
            [_objects insertObject:[app getOwnerActivityAndForceReload:NO] atIndex:0];
            self.hasActivity = YES;
        }
        else {
            [_objects insertObject:@"NIL" atIndex:0];
            self.hasActivity = NO;
         }
    }    
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_objects count];
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
    
    if([[_objects[indexPath.row] description] isEqualToString:@"NIL"]) {
        
        UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [pushButton addTarget:self
                       action:@selector(pushViewController:)
             forControlEvents:UIControlEventTouchDown];
        pushButton.frame = (CGRect){0, - 3, 320, 51};
        
        [pushButton setBackgroundImage:[UIImage imageNamed:@"buttonBroadcastAvailability"] forState:UIControlStateNormal];
        [cell addSubview:pushButton];
    }
    else
        cell.textLabel.text = [_objects[indexPath.row] description];
    
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
    if(indexPath.row > 0) {
        DetailProfileViewController *detail = [[[DetailProfileViewController alloc] init] autorelease];
        [((AppDelegate*)[UIApplication sharedApplication].delegate).viewController.navigationController pushViewController:detail animated:YES];
        detail = nil;
    }
    else if(![[_objects[indexPath.row] description] isEqualToString:@"NIL"]) {
        Activity* act = (Activity*)_objects[indexPath.row];
        [self pushViewController:act];
    }
}

@end
