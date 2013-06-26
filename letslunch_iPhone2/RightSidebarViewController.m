//
//  RightSidebarViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 18/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "RightSidebarViewController.h"
#import "AppDelegate.h"

@implementation RightSidebarViewController
@synthesize sidebarDelegate;
@synthesize menuItem;

#pragma view lifecycle

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if(!self.menuItem) {
        self.menuItem = [[NSArray alloc] initWithObjects:@"Activity", @"Message", @"Friends", nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.menuItem = nil;
    self.sidebarDelegate = nil;
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuItem count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) 
        return 85;
    else
        return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
        UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
        [share setImage:[UIImage imageNamed:@"ShareButton.png"] forState:UIControlStateNormal];
        [share sizeToFit];
        [share addTarget:((AppDelegate*)[[UIApplication sharedApplication] delegate]).viewController
                             action:@selector(shareButtonClick:)
                   forControlEvents:UIControlEventTouchUpInside];
        
        share.frame = (CGRect){x, y, 252, 35};
        [cell addSubview:share];
        
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
        
        /*
         Add the button to invite friends
         Uses image in Image folder
         Call inviteFriendsButtonClick function in CenterViewController
         */
        UIButton *inviteFriendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [inviteFriendButton setImage:[UIImage imageNamed:@"InviteFriendsButton.png"] forState:UIControlStateNormal];
        [inviteFriendButton sizeToFit];
        [inviteFriendButton addTarget:((AppDelegate*)[[UIApplication sharedApplication] delegate]).viewController
                             action:@selector(inviteFriendsButtonClick:)
                   forControlEvents:UIControlEventTouchUpInside];
        
        inviteFriendButton.frame = (CGRect){x + 130, y, 120, 32};
        [cell addSubview:inviteFriendButton];
    }
    else {
        /*
         Part to take care of the title
         We use a UILabel because cell.textLabel can't be moved
         */
        int x = 60;
        int y = 5;
        UILabel *title = [[[UILabel alloc] initWithFrame:CGRectMake(x, y, cell.frame.size.width - x, cell.frame.size.height - y)] autorelease];
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

- (void)click:(id)sender
{
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sidebarDelegate) {
        NSLog(@"%d", indexPath.row);
        //NSObject *object = [NSString stringWithFormat:@"ViewController%d", indexPath.row];
        //[self.sidebarDelegate sidebarViewController:self didSelectObject:(float)indexPath.row atIndexPath:indexPath];
    }
}

@end
