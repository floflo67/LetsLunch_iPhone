//
//  DetailProfileViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 03/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "DetailProfileViewController.h"

@interface DetailProfileViewController ()

@end

@implementation DetailProfileViewController

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
    if(!self.objects) {
        self.objects = [[[NSMutableArray alloc] initWithObjects:@"Name", @"Description", @"Other", nil] autorelease];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    
    cell.textLabel.text = self.objects[indexPath.row];
    
    return cell;
}

- (void)dealloc
{
    [self.objects release];
    [super dealloc];
}

@end
