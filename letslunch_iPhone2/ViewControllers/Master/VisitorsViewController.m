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
#import "VisitorsRequest.h"

@interface VisitorsViewController ()
@property (nonatomic, strong) NSMutableArray* objects;
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
    if (self) {
        self.objects = [[[VisitorsRequest alloc] init] getVisitorsWithToken:[AppDelegate getToken]];
        if([self.objects count] == 0)
            return nil;
    }    
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.objects count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *profile = [NSDictionary dictionaryWithDictionary:self.objects[indexPath.row]];
    Contacts *contact = [[Contacts alloc] initWithDictionary:profile];
    
    cell.textLabel.text = contact.firstname;
    contact = nil;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSDictionary *profile = [NSDictionary dictionaryWithDictionary:self.objects[indexPath.row]];
    Contacts *contact = [[Contacts alloc] initWithDictionary:profile];
    
    [self.navigationController pushViewController:[[DetailProfileViewController alloc] initWithContactID:contact.ID] animated:YES];
    contact = nil;
}

#pragma mark - getter and setter

- (NSMutableArray*)objects
{
    if(!_objects)
        _objects = [[NSMutableArray alloc] init];
    return _objects;
}

- (UINavigationController*)navigationController
{
    return ((AppDelegate*)[UIApplication sharedApplication].delegate).viewController.navigationController;
}

@end
