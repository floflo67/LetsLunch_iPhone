//
//  ContactViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 25/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "ContactViewController.h"
#import "MessageViewController.h"
#import "CreateActivityViewController.h"
#import "Thread.h"

@interface ContactViewController ()
@property (nonatomic, strong) NSMutableArray* objects;
@end

@implementation ContactViewController

static ContactViewController *sharedSingleton = nil;
+ (ContactViewController*)getSingleton
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
    if(self) {
        self.objects = [(AppDelegate*)[[UIApplication sharedApplication] delegate] getListContactsAndForceReload:NO];
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
    Thread *thread = (Thread*)self.objects[indexPath.row];
    cell.textLabel.text = thread.receiver.firstname;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    Thread *thread = (Thread*)self.objects[indexPath.row];
    MessageViewController *messagesViewController = [[MessageViewController alloc] initWithThreadID:thread.ID];
    if(messagesViewController) {
        [self.navigationController pushViewController:messagesViewController animated:YES];
        messagesViewController = nil;
    }
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
