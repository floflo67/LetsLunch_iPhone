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

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(!self.menuItem) {
        self.menuItem = [[NSArray alloc] initWithObjects:@"Activity", @"Message", @"Friends", nil];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if ([self.sidebarDelegate respondsToSelector:@selector(lastSelectedIndexPathForSidebarViewController:)]) {
        NSIndexPath *indexPath = [self.sidebarDelegate lastSelectedIndexPathForSidebarViewController:self];
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BackgroundMenuItem.png"]];
    [cell addSubview:background];
    //cell.contentMode = UIViewContentModeScaleAspectFill;
    NSString *imageName = [NSString stringWithFormat:@"%@MenuItem.png",[self.menuItem[indexPath.row] description]];
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [icon setFrame:CGRectMake(5, 5, 40, 40)];
    [cell addSubview:icon];
    
    UILabel *title = [[[UILabel alloc] initWithFrame:CGRectMake(50, 0, cell.frame.size.width - 50, cell.frame.size.height)] autorelease];
    
    title.text = [self.menuItem[indexPath.row] description];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont fontWithName:@"Academy Engraved LET Bold" size:14];
    [cell.contentView addSubview:title];
    
    [cell sendSubviewToBack:background];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sidebarDelegate) {
        //NSObject *object = [NSString stringWithFormat:@"ViewController%d", indexPath.row];
        [self.sidebarDelegate sidebarViewController:self didSelectObject:(float)indexPath.row atIndexPath:indexPath];
    }
}

@end
