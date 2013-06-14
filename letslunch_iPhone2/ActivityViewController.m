//
//  ActivityViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "ActivityViewController.h"
#import "AppDelegate.h"

@interface ActivityViewController ()

@end

@implementation ActivityViewController

static ActivityViewController *sharedSingleton = nil;
+ (ActivityViewController*)getSingleton
{
    if (sharedSingleton !=nil)
    {
        NSLog(@"ActivityViewController has already been created.....");
        return sharedSingleton;
    }
    @synchronized(self)
    {
        if (sharedSingleton == nil)
        {
            sharedSingleton = [[self alloc]init];
            NSLog(@"Created a new ActivityViewController");
        }
    }
    return sharedSingleton;
}


-(id)init
{
    self = [super init];
    if(!_objects) {
        AppDelegate* app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSMutableArray* listActivities = [[NSMutableArray alloc] initWithArray:[app getListActivities] copyItems:YES];
        
        
        if([app getOwnerActivity]) {
           [listActivities insertObject:[app getOwnerActivity] atIndex:0];
            self.hasActivity = YES;
        }
        else
            self.hasActivity = NO;
        
        _objects = [[NSMutableArray alloc] initWithArray:listActivities];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(!self.hasActivity)
        return [_objects count] + 1;
    else
        return [_objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if(!self.hasActivity) {
        if(indexPath.row == 0) {
            UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [pushButton setTitle:@"Create Activity" forState:UIControlStateNormal];
            [pushButton sizeToFit];
            [pushButton addTarget:((AppDelegate*)[[UIApplication sharedApplication] delegate]).viewController
                           action:@selector(pushNewViewController:)
                 forControlEvents:UIControlEventTouchUpInside];
            
            pushButton.frame = (CGRect){0, 0, cell.frame.size.width, cell.frame.size.height};
            [cell addSubview:pushButton];
            
        }
        else {
            cell.textLabel.text = [_objects[indexPath.row - 1] description];
        }
    }
    else {
        cell.textLabel.text = [_objects[indexPath.row] description];        
    }
    
    
    return cell;
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
