//
//  InviteViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 15/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "InviteViewController.h"
#import "InviteContactsViewController.h"
#import "FacebookFriend.h"
#import <MessageUI/MessageUI.h>

@interface InviteViewController () <MFMessageComposeViewControllerDelegate>
@property (nonatomic, strong) NSArray *objects;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) FBFriendPickerViewController *friendPickerController;
@property (nonatomic, strong) NSMutableArray *facebookFriends;
@property (nonatomic, strong) NSMutableArray *facebookFriendsID;
@end

@implementation InviteViewController

static InviteViewController *sharedSingleton = nil;
+ (InviteViewController*)getSingleton
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.objects = @[@"Contacts", @"Facebook", @"Twitter"];
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
    cell.textLabel.text = [self.objects[indexPath.row] description];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    InviteContactsViewController *vc = [[InviteContactsViewController alloc] init];
    switch (indexPath.row) {
        case 0: // contacts
            [self.navigationController pushViewController:vc animated:YES];
            //[self sendText];
            break;
        case 1: // facebook
            [self getFacebookFriend];
            break;
        case 2: // twitter
            break;
        default:
            break;
    }
}

#pragma mark - invite Contacts

-(void)sendTextWithPhoneNumbers:(NSArray*)selectedPhoneNumber;
{    
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *smsController = [[MFMessageComposeViewController alloc] init];
        smsController.messageComposeDelegate = self;
        smsController.body = @"check out apps, link";
        smsController.recipients = selectedPhoneNumber;
        [self presentViewController:smsController animated:YES completion:nil];
        smsController = nil;
    }
    else
        [AppDelegate showErrorMessage:@"Device cannot send texts!" withTitle:@"500"];
}

#pragma mark - MFMessageComposeViewController delegate

- (void)messageComposeViewController:(MFMessageComposeViewController*)controller didFinishWithResult:(MessageComposeResult)result
{
    if(result == MessageComposeResultSent) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"The message was sent successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The message was not sent" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
    }
}

#pragma mark - temp

- (void)getFacebookFriend
{
    [self showRequestForFacebook];
    
    // FBSample logic
    // if the session is open, then load the data for our view controller
    /*
    if (!FBSession.activeSession.isOpen) {
        // if the session is closed, then we open it here, and establish a handler for state changes
        [FBSession openActiveSessionWithReadPermissions:nil allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
            else if (session.isOpen)
                [self getFacebookFriend];
        }];
        return;
    }
    
    if (self.friendPickerController == nil) {
        // Create friend picker, and get data loaded into it.
        self.friendPickerController = [[FBFriendPickerViewController alloc] init];
        self.friendPickerController.title = @"Friends";
        self.friendPickerController.delegate = self;
        self.friendPickerController.SortOrdering = FBFriendSortByLastName;
        self.friendPickerController.displayOrdering = FBFriendDisplayByLastName;
        self.friendPickerController.itemPicturesEnabled = YES;
    }
    
    [self.friendPickerController loadData];
    [self.friendPickerController clearSelection];
    
    [((AppDelegate*)[UIApplication sharedApplication].delegate).viewController presentViewController:self.friendPickerController animated:YES completion:nil];
     */
}

#pragma mark - FBFriendPickerViewController delegate

- (void)facebookViewControllerDoneWasPressed:(id)sender
{
    for (id<FBGraphUser> user in self.friendPickerController.selection) {
        [self.facebookFriends addObject:[[FacebookFriend alloc] initWithID:user.id firstname:user.first_name andLastname:user.last_name]];
        [self.facebookFriendsID addObject:user.id];
    }
    [((AppDelegate*)[UIApplication sharedApplication].delegate).viewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)facebookViewControllerCancelWasPressed:(id)sender
{
    [((AppDelegate*)[UIApplication sharedApplication].delegate).viewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Custom function

- (void)showRequestForFacebook
{
    //NSArray *suggestedFriends = [[NSArray alloc] initWithObjects:@"286400088", @"685145706", @"596824621", @"555279551", nil];
    //NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"100006504845625", @"to", nil]; // John Smith
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:nil];
    
    if([FBSession activeSession].isOpen) {
        [FBWebDialogs presentRequestsDialogModallyWithSession:[FBSession activeSession] message:@"Join me on Letslunch.com." title:@"Invite" parameters:params handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
            if (error)
                NSLog(@"Error sending request.");
            else {
                if (result == FBWebDialogResultDialogNotCompleted)
                    NSLog(@"User canceled request.");
                else if(result == FBWebDialogResultDialogCompleted)
                    NSLog(@"Request: %@", resultURL);
                else
                    NSLog(@"Error unknown.");
            }
        }];        
    }
    else {
        [FBSession openActiveSessionWithReadPermissions:@[@"email"] allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            if(session.isOpen) {
                [FBSession openActiveSessionWithPublishPermissions:@[@"publish_actions"] defaultAudience:FBSessionDefaultAudienceEveryone allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                    if(session.isOpen) {
                        [self showRequestForFacebook];
                    }
                }];
            }
        }];
    }
}

#pragma mark - getter and setter

- (NSArray*)objects
{
    if(!_objects)
        _objects = [[NSArray alloc] init];
    return _objects;
}

- (NSMutableArray*)facebookFriends
{
    if(!_facebookFriends)
        _facebookFriends = [[NSMutableArray alloc] init];
    return _facebookFriends;
}

- (NSMutableArray*)facebookFriendsID
{
    if(!_facebookFriendsID)
        _facebookFriendsID = [[NSMutableArray alloc] init];
    return _facebookFriendsID;
}

- (UINavigationController*)navigationController
{
    return ((AppDelegate*)[UIApplication sharedApplication].delegate).viewController.navigationController;
}

@end
