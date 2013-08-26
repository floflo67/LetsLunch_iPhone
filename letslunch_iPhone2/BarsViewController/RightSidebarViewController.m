//
//  RightSidebarViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 18/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "RightSidebarViewController.h"

@interface RightSidebarViewController()
@property (nonatomic, strong) NSArray* menuItem;
@property (nonatomic, strong) UIButton *share;
@end

@implementation RightSidebarViewController
@synthesize sidebarDelegate;

#pragma mark - view lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.menuItem = @[@"NIL", @"Message", @"Friends"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menuItem count];
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row == 0) 
        return 85;
    else
        return 44;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    /*
     Use image as background
     */
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BackgroundSharing.png"]];
    if(indexPath.row == 0)
        background.frame = CGRectMake(cell.frame.origin.x - 10, cell.frame.origin.y, 280, cell.frame.size.height + 47);
    else
        background.frame = CGRectMake(cell.frame.origin.x - 10, cell.frame.origin.y, 280, cell.frame.size.height + 5);
    [cell addSubview:background];
    
    if(indexPath.row == 0) {
        int x = 10;
        int y = 10;
        
        /*
         Add the button to share
         Uses image in Image folder
         Call shareButtonClick function in CenterViewController
         */
        [self.share addTarget:((AppDelegate*)[[UIApplication sharedApplication] delegate]).viewController action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell addSubview:self.share];
        [self changeShareButton];
        
        y+= 40;
        /*
         Add the button to find
         Uses image in Image folder
         Call findFriendsButtonClick function in CenterViewController
         */
        UIButton *findFriendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [findFriendButton setImage:[UIImage imageNamed:@"FindFriendsButton.png"] forState:UIControlStateNormal];
        [findFriendButton sizeToFit];
        [findFriendButton addTarget:((AppDelegate*)[[UIApplication sharedApplication] delegate]).viewController
                       action:@selector(findFriendsButtonClick:)
             forControlEvents:UIControlEventTouchUpInside];
        
        findFriendButton.frame = (CGRect){x, y, 120, 32};
        [cell addSubview:findFriendButton];
    }
    else {
        /*
         Part to take care of the title
         We use a UILabel because cell.textLabel can't be moved
         */
        int x = 60;
        int y = 5;
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(x, y, cell.frame.size.width - x, cell.frame.size.height - y)];
        title.text = [self.menuItem[indexPath.row] description];
        title.backgroundColor = [UIColor clearColor];
        title.textColor = [UIColor grayColor];
        title.font = [UIFont fontWithName:@"Academy Engraved LET Bold" size:14];
        [cell.contentView addSubview:title];
    }
    
    [cell sendSubviewToBack:background]; // otherwise don't see anything
    
    background = nil;
    
    return cell;
}

- (void)changeShareButton
{
    if(![AppDelegate getAppDelegate].ownerActivity)
        self.share.enabled = NO;
    else
        self.share.enabled = YES;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    if (self.sidebarDelegate) {
        //NSObject *object = [NSString stringWithFormat:@"ViewController%d", indexPath.row];
        //[self.sidebarDelegate sidebarViewController:self didSelectObject:(float)indexPath.row atIndexPath:indexPath];
    }
}

#pragma mark - getter and setter

- (NSArray*)menuItem
{
    if(!_menuItem)
        _menuItem = [[NSArray alloc] init];
    return _menuItem;
}

- (UIButton *)share
{
    if(!_share) {
        _share = [UIButton buttonWithType:UIButtonTypeCustom];
        [_share setImage:[UIImage imageNamed:@"ShareButton.png"] forState:UIControlStateNormal];
        [_share sizeToFit];
        _share.frame = (CGRect){10, 10, 252, 35};
    }
    return _share;
}

@end
