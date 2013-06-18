//
//  RightSidebarViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 18/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "RightSidebarViewController.h"

@implementation RightSidebarViewController
@synthesize sidebarDelegate;
@synthesize menuItem;

#pragma view lifecycle

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
    [self.menuItem release];
    [self.sidebarDelegate release];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if(indexPath.row == 0) {
        UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(40, 5, 150, 20)] autorelease];
        //[button actionsForTarget:@selector(click:) forControlEvent:UIControlEventTouchDown];
        button.titleLabel.text = @"Text";
        [cell addSubview:button];
    }
    
    int randNumRed = rand() % (255 - 0) + 0;
    int randNumGreen = rand() % (255 - 0) + 0;
    int randNumBlue = rand() % (255 - 0) + 0;
    
    cell.backgroundColor = [UIColor colorWithRed:randNumRed/255 green:randNumGreen/255 blue:randNumBlue/255 alpha:1];
    
    cell.textLabel.text = self.menuItem[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Academy Engraved LET Bold" size:14];
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
