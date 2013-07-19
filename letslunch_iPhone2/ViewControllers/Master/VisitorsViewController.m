//
//  VisitorsViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 19/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "VisitorsViewController.h"
#import "AppDelegate.h"
#import "Contacts.h"

@interface VisitorsViewController ()

@end

@implementation VisitorsViewController

static VisitorsViewController *sharedSingleton = nil;
+ (VisitorsViewController*)getSingleton
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

- (id)init
{
    self = [super init];
    NSString *token = [AppDelegate getObjectFromKeychainForKey:kSecAttrAccount];
    if (self) {
        if(!_visitorRequest)
            _visitorRequest = [[VisitorsRequest alloc] init];
        
        if(!_objects)
            _objects = [[NSMutableArray alloc] init];
        _objects = [[_visitorRequest getVisitorsWithToken:token] retain];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    
    NSDictionary *profile = [NSDictionary dictionaryWithDictionary:_objects[indexPath.row]];
    NSLog(@"%@", profile);
    Contacts *contact = [[Contacts alloc] initWithDict:profile];
    
    cell.textLabel.text = contact.publicname;
    
    [contact release];
    return cell;
}

/*
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     
}*/

@end
