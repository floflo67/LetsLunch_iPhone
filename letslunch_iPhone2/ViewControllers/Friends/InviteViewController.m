//
//  InviteViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 15/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "InviteViewController.h"
#import "InviteContactsViewController.h"

@interface InviteViewController ()
@property (strong, nonatomic) NSArray *objects;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) FBFriendPickerViewController *friendPickerController;
@end

@implementation InviteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        self.objects = @[@"Contacts", @"Facebook", @"Twitter"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
            break;
        case 1:
            [self getFacebookFriend];
            break;
        case 2: // twitter
            break;
        default:
            break;
    }
}

#pragma mark - temp

- (void)getFacebookFriend {
    // FBSample logic
    // if the session is open, then load the data for our view controller
    if (!FBSession.activeSession.isOpen) {
        // if the session is closed, then we open it here, and establish a handler for state changes
        [FBSession openActiveSessionWithReadPermissions:nil
                                           allowLoginUI:YES
                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                          if (error) {
                                              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                              [alertView show];
                                          } else if (session.isOpen) {
                                              [self getFacebookFriend];
                                          }
                                      }];
        return;
    }
    
    if (self.friendPickerController == nil) {
        // Create friend picker, and get data loaded into it.
        self.friendPickerController = [[FBFriendPickerViewController alloc] init];
        self.friendPickerController.title = @"Pick Friends";
        self.friendPickerController.delegate = self;
    }
    
    [self.friendPickerController loadData];
    [self.friendPickerController clearSelection];
    
    [self presentViewController:self.friendPickerController animated:YES completion:nil];
}

- (void)facebookViewControllerDoneWasPressed:(id)sender {
    NSMutableString *text = [[NSMutableString alloc] init];
    
    // we pick up the users from the selection, and create a string that we use to update the text view
    // at the bottom of the display; note that self.selection is a property inherited from our base class
    for (id<FBGraphUser> user in self.friendPickerController.selection) {
        if ([text length]) {
            [text appendString:@", "];
        }
        [text appendString:user.id];
    }
    
    [self fillTextBoxAndDismiss:text.length > 0 ? text : @"<None>"];
}

- (void)facebookViewControllerCancelWasPressed:(id)sender {
    [self fillTextBoxAndDismiss:@"<Cancelled>"];
}

- (void)fillTextBoxAndDismiss:(NSString *)text {
    NSLog(@"%@", text);    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getter and setter

- (NSArray*)objects
{
    if(!_objects)
        _objects = [[NSArray alloc] init];
    return _objects;
}

@end
