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
#import "DetailProfileViewController.h"

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

+ (void)suppressSingleton
{
    if (sharedSingleton != nil)
        sharedSingleton = nil;
}

- (id)init
{
    self = [super init];
    NSString *token = [AppDelegate getObjectFromKeychainForKey:(__bridge id)(kSecAttrAccount)];
    if (self) {
        if(!_visitorRequest)
            _visitorRequest = [[VisitorsRequest alloc] init];
        
        if(!_objects)
            _objects = [[NSMutableArray alloc] init];
        _objects = [_visitorRequest getVisitorsWithToken:token];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *profile = [NSDictionary dictionaryWithDictionary:_objects[indexPath.row]];
    Contacts *contact = [[Contacts alloc] initWithDictionary:profile];
    
    cell.textLabel.text = contact.firstname;
    contact = nil;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *profile = [NSDictionary dictionaryWithDictionary:_objects[indexPath.row]];
    Contacts *contact = [[Contacts alloc] initWithDictionary:profile];
    
    DetailProfileViewController *detailViewController = [[DetailProfileViewController alloc] initWithContactID:contact.ID];
    [((AppDelegate*)[UIApplication sharedApplication].delegate).viewController.navigationController pushViewController:detailViewController animated:YES];
    contact = nil;
    detailViewController = nil;
}

@end
