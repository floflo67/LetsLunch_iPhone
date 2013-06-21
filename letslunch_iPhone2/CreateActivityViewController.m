//
//  CreateActivityViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "CreateActivityViewController.h"
#import "AppDelegate.h"
#import "NearbyVenuesViewController.h"

@interface CreateActivityViewController ()

@end

@implementation CreateActivityViewController

static CreateActivityViewController *sharedSingleton = nil;
+ (CreateActivityViewController*)getSingleton
{
    if (sharedSingleton !=nil)
    {
        NSLog(@"CreateActivityViewController has already been created.....");
        return sharedSingleton;
    }
    @synchronized(self)
    {
        if (sharedSingleton == nil)
        {
            sharedSingleton = [[self alloc] init];
            NSLog(@"Created a new CreateActivityViewController");
        }
    }
    return sharedSingleton;
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
    self.navigationItem.title = @"Create Activity";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                              target:((AppDelegate*)[UIApplication sharedApplication].delegate).viewController
                                              action:@selector(saveActivity:)];
    
    _objects = [[NSMutableArray alloc] initWithObjects:@"Description", @"Place", @"Time", @"Type", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    sectionName = [_objects objectAtIndex:section];
    return sectionName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    //UILabel* label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 1, cell.frame.size.width / 2 - 2, cell.frame.size.height - 2)] autorelease];
    //[cell addSubview:label];
    //label.backgroundColor = [UIColor clearColor];
    //UITextField* text = [[[UITextField alloc] initWithFrame:CGRectMake(cell.frame.size.width / 2, 0, cell.frame.size.width / 2, cell.frame.size.height)] autorelease];
    //[cell addSubview:text];
    
    //label.text = [arr objectAtIndex:indexPath.row];
    
    NSString *section = [_objects objectAtIndex:indexPath.section];
    if([section isEqualToString:@"Description"]) {
        
    }
    else if([section isEqualToString:@"Time"]) {
        /*
        UIDatePicker *date = [[UIDatePicker alloc] init];
        date.frame = CGRectMake(cell.contentView.frame.origin.x, cell.contentView.frame.origin.x, cell.contentView.frame.size.width, cell.contentView.frame.size.height);
        date.minuteInterval = 15;
        date.date = [NSDate new];
        date.datePickerMode = UIDatePickerModeTime;
        [cell.contentView addSubview:date];
         */
    }
    else if ([section isEqualToString:@"Place"]) {
        cell.textLabel.text = @"Optional";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [but addTarget:self action:@selector(pushSelectPlace:) forControlEvents:UIControlEventTouchUpInside];
        
        but.frame = (CGRect){270, 0, 50, 50};
        [cell addSubview:but];        
    }
    else if([section isEqualToString:@"Type"]) {
        UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"Coffee", @"Lunch"]];
        segment.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.x, cell.frame.size.width - 20, cell.frame.size.height);
        segment.segmentedControlStyle = UISegmentedControlStyleBar;
        segment.tintColor = [UIColor orangeColor];
        [cell.contentView addSubview:segment];
    }
    
    return cell;
}

-(void)pushSelectPlace:(id)sender
{
    [self.navigationController pushViewController:[[NearbyVenuesViewController alloc] init] animated:YES];
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
