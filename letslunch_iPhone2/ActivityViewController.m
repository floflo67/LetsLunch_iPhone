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
        _objects = [[NSMutableArray alloc] init];
        
        NSDictionary* dict;
        if([app getOwnerActivity]) {
            dict = [NSDictionary dictionaryWithObject:[NSArray arrayWithObject:[app getOwnerActivity]] forKey:@"Activities"];
            self.hasActivity = YES;
        }
        else {
            dict = [NSDictionary dictionaryWithObject:[NSArray arrayWithObject:@"NIL"] forKey:@"Activities"];
            self.hasActivity = NO;
         }
        
        [_objects addObject:dict];
        
        NSMutableArray* listActivities = [[NSMutableArray alloc] initWithArray:[app getListActivities] copyItems:YES];
        NSDictionary *listActivitiesDict = [NSDictionary dictionaryWithObject:listActivities forKey:@"Activities"];
        
        [_objects addObject:listActivitiesDict];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    NSDictionary *dictionary = [_objects objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"Activities"];
    return [array count];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            if(self.hasActivity) {
                sectionName = @"Your activity";
            }
            else {
                sectionName = @"Create activity";
            }
            break;
        case 1:
            sectionName = @"Activities around you";
            break;
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dictionary = [_objects objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"Activities"];
    
    if([[array[indexPath.row] description] isEqualToString:@"NIL"]) {
        UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [pushButton setTitle:@"Create Activity" forState:UIControlStateNormal];
        [pushButton sizeToFit];
        [pushButton addTarget:((AppDelegate*)[[UIApplication sharedApplication] delegate]).viewController
                       action:@selector(pushCreateActivityViewController:)
             forControlEvents:UIControlEventTouchUpInside];
        
        pushButton.frame = (CGRect){0, 0, cell.frame.size.width, cell.frame.size.height};
        [cell addSubview:pushButton];
    }
    else
        cell.textLabel.text = [array[indexPath.row] description];
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
