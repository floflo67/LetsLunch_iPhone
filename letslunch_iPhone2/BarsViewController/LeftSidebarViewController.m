//
//  SidebarViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "LeftSidebarViewController.h"

@implementation LeftSidebarViewController
@synthesize sidebarDelegate;
@synthesize menuItem;
@synthesize index;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

#pragma view lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(!self.menuItem) {
        self.index = 0;
        self.menuItem = [[NSArray alloc] initWithObjects:@"Profile", @"Activity", @"Messages", @"Visitors", @"Settings", @"Notifications", @"Logout", nil];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if ([self.sidebarDelegate respondsToSelector:@selector(lastSelectedIndexPathForSidebarViewController:)]) {
        NSIndexPath *indexPath = [self.sidebarDelegate lastSelectedIndexPathForSidebarViewController:self];
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

- (void)dealloc {
    [self.menuItem release];
    [self.sidebarDelegate release];
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; // No sections
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    /*
     Use image as background
     */
    /*
    UIImageView *background;
    if(self.index == indexPath.row)
        background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BackgroundMenuItemSelected.png"]];
    else
        background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BackgroundMenuItem.png"]];
     */
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BackgroundMenuItem.png"]];
    background.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, 275, cell.frame.size.height + 8);
    [cell addSubview:background];
    
    /*
     Load image dynamically depending on name of item
     */
    NSString *imageName;
    UIImageView *icon;
    if([[self.menuItem[indexPath.row] description] isEqualToString:@"Profile"]) {
        imageName = [AppDelegate getObjectFromKeychainForKey:kSecAttrDescription];
        UIImage *img = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageName]]];        
        icon = [[UIImageView alloc] initWithImage:img];
        [img release];
    }
    else {
        imageName = [NSString stringWithFormat:@"%@MenuItem.png",[self.menuItem[indexPath.row] description]];
        icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    }
    [icon setFrame:CGRectMake(10, 10, 30, 30)];
    [cell addSubview:icon];
    
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
    
    [cell sendSubviewToBack:background]; // otherwise don't see anything
    
    /*
     Release elements in cell
     */
    background = nil;
    icon = nil;
    title = nil;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sidebarDelegate) {
        self.index = indexPath.row;
        NSObject *obj = menuItem[indexPath.row];
        [self.sidebarDelegate sidebarViewController:self didSelectObject:obj atIndexPath:indexPath];
    }
}

@end
