//
//  InviteContactsViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 15/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "InviteContactsViewController.h"
#import "DBFriendInviter.h"
#import "InviteViewController.h"
#import <AddressBookUI/AddressBookUI.h>

@interface InviteContactsViewController ()
@property (nonatomic, strong) NSArray *objects;
@property (nonatomic, strong) NSMutableArray *selectedContacts;
@property (nonatomic, strong) NSMutableArray *phoneNumbers;
@property (nonatomic) ABAddressBookRef addressBook;
@end

@implementation InviteContactsViewController

- (void)viewDidAppear:(BOOL)animated
{
    if ([self.objects count]) {
        return;
    }
    
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    if (!addressBook) {
        NSLog(@"Failed to access the address book: %@", error);
        return;
    }
    
    __block BOOL accessGranted = NO;
    if (ABAddressBookRequestAccessWithCompletion != NULL) {
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    
    if (accessGranted) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
            self.objects = [DBFriendInviter mostImportantContacts];            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [self.tableView reloadData];
            });
        });
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Contacts";
    self.objects = nil;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(sendText)];
}

#pragma mark - Button events

- (void)sendText
{
    if([self.selectedContacts count] > 0) {
        for (__DBContactScorePair *record in self.selectedContacts) {
            [self.phoneNumbers addObject:record.phoneNumber];
        }
        [[InviteViewController getSingleton] sendTextWithPhoneNumbers:self.phoneNumbers];
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    
    __DBContactScorePair *contact = [self.objects objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%i: %@ - %@", contact.contactID, contact.contactName, contact.phoneNumber];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    __DBContactScorePair *contact = [self.objects objectAtIndex:indexPath.row];
    [self.selectedContacts addObject:contact];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __DBContactScorePair *contact = [self.objects objectAtIndex:indexPath.row];
    [self.selectedContacts removeObject:contact];
}

#pragma mark - getter and setter

- (NSArray*)objects
{
    if(!_objects)
        _objects = [[NSArray alloc] init];
    return _objects;
}

- (ABAddressBookRef)addressBook
{
    CFErrorRef error = NULL;
    if(!_addressBook)
        _addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    if(error)
        return nil;
    return _addressBook;
}

-(NSMutableArray *)selectedContacts
{
    if(!_selectedContacts)
        _selectedContacts = [[NSMutableArray alloc] init];
    return _selectedContacts;
}

-(NSMutableArray *)phoneNumbers
{
    if(!_phoneNumbers)
        _phoneNumbers = [[NSMutableArray alloc] init];
    return _phoneNumbers;
}

@end
