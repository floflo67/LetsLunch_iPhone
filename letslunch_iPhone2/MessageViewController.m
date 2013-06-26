//
//  MessageViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "MessageViewController.h"
#import "AppDelegate.h"
#import "Messages.h"
#import "ThreadCell.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

-(id)init
{
    self = [super init];
    if(self) {
        if(!_objects) {
            _objects = [[NSMutableArray alloc] initWithArray:[(AppDelegate*)[[UIApplication sharedApplication] delegate]
                                                              getListMessagesForContactID:@"1"]];
        }
    }
    return self;
}

- (id)initWithContactID:(NSString*)contactID
{
    self = [super init];
    if(self) {
        if(!_objects) {
            self.contactID = contactID;
            _objects = [[NSMutableArray alloc] initWithArray:[(AppDelegate*)[[UIApplication sharedApplication] delegate]
                                                              getListMessagesForContactID:contactID]];
        }
    }
    return self;
}

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
    self.navigationItem.title = @"Messages";
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_objects count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ThreadCell *cell = (ThreadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ThreadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Messages *mess = _objects[indexPath.section];
    
    /*
     Message sent by user
     */
    if([mess.contactIDFrom isEqualToString:self.contactID]) {
        cell.imgName = @"MessageFromSelf.png";
        cell.tipRightward = NO;
    }
    else {
        cell.imgName = @"MessageToSelf.png";
        cell.tipRightward = YES;
    }
    
    cell.msgText = [mess description];
    mess = nil;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *aMsg = [[_objects objectAtIndex:indexPath.section] description];
    CGFloat widthForText = 260.f;    
	CGSize size = [ThreadCell calcTextHeight:aMsg withinWidth:widthForText];	
	return size.height - 5;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title;
    Messages *mess1 = (Messages*)_objects[section];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd, yyyy HH:mm"];
    
    if(section > 0) {
        Messages *mess2 = (Messages*)_objects[section - 1];
        
        if(![mess1.contactIDFrom isEqualToString:mess2.contactIDFrom]) {
            title = [format stringFromDate:mess1.date];
        }
        else {
            title = nil;
        }
    }
    else {
        title = [format stringFromDate:mess1.date];
    }
    
    return title;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
