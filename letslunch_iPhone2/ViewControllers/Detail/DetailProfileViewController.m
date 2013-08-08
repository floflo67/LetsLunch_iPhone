//
//  DetailProfileViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 22/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "DetailProfileViewController.h"
#import "ProfileDetailsRequest.h"
#import "MessageViewController.h"

@interface DetailProfileViewController ()
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray* objects;
@property (nonatomic, strong) NSString *contactID;
@property (weak, nonatomic) IBOutlet UIButton *wishListButton;
@end

@implementation DetailProfileViewController

- (id)initWithContactID:(NSString*)contactID
{
    self = [super init];
    if(self) {
        NSDictionary *dict = [[[ProfileDetailsRequest alloc] init] getProfileWithToken:[AppDelegate getToken] andID:contactID];
        
        NSMutableDictionary *profile = [NSMutableDictionary dictionaryWithDictionary:[dict objectForKey:@"profile"]];
        [profile removeObjectForKey:@"uid"];
        
        NSDictionary *location = [NSDictionary dictionaryWithDictionary:[dict objectForKey:@"location"]];
        NSDictionary *other = [NSDictionary dictionaryWithDictionary:[dict objectForKey:@"other"]];
        NSArray *skills = [NSArray arrayWithArray:[dict objectForKey:@"skills"]];
        NSArray *needs = [NSArray arrayWithArray:[dict objectForKey:@"needs"]];
        NSDictionary *mediaLinks = [NSDictionary dictionaryWithDictionary:[dict objectForKey:@"socialMediaLinks"]];
        NSArray *testimonials = [NSArray arrayWithArray:[dict objectForKey:@"testimonials"]];        
        BOOL isOnWishlist = [[dict objectForKey:@"onWishList"] boolValue];
        if(isOnWishlist)
            self.wishListButton.selected = YES;
            
        
        self.objects = (NSMutableArray*)@[profile, location, other, skills, needs, testimonials, mediaLinks];
        self.contactID = contactID;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return [self.objects count];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = [(NSArray*)self.objects[section] count];
    if(number == 0 && section >= 3)
        number++;
    else if (section == 2 && number == 0) {
        [AppDelegate showNoConnectionMessage];
    }
    return number;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Profile";
            break;
        case 1:
            return @"Address";
            break;
        case 2:
            return @"Other";
            break;
        case 3:
            return @"Skills";
            break;
        case 4:
            return @"Needs";
            break;
        case 5:
            return @"Testimonials";
            break;
        case 6:
            return @"Social";
            break;
        default:
            return @"";
            break;
    }
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    if(indexPath.section < 3) {
        NSDictionary *dict = (NSDictionary*)self.objects[indexPath.section];
        
        NSArray *allKeys = [dict allKeys];
        NSArray *allValues = [dict allValues];
        
        if([allKeys count] > indexPath.row) {
            NSString *key = allKeys[indexPath.row];
            NSString *keyCapitalized = [key stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[key substringToIndex:1] capitalizedString]];
            
            cell.textLabel.text = keyCapitalized;
            cell.detailTextLabel.text = allValues[indexPath.row];
        }
        else {
            cell.textLabel.text = @"Error connection";
            cell.detailTextLabel.text = @"";
        }
    }
    else if(indexPath.section < 5) {
        NSArray *array = (NSArray*)self.objects[indexPath.section];
        if([array count] == 0) {
            cell.textLabel.text = @"None listed";
            cell.detailTextLabel.text = @"";
        }
        else {
            cell.textLabel.text = [array[indexPath.row] objectForKey:@"name"];
            cell.detailTextLabel.text = @"";
        }
    }
    else if (indexPath.section == 6) {
        NSDictionary *dict = (NSDictionary*)self.objects[indexPath.section];
        if([dict count] > 0) {
            NSArray *allKeys = [dict allKeys];
            NSArray *allValues = [dict allValues];
            
            NSString *key = allKeys[indexPath.row];
            NSString *keyCapitalized = [key stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[key substringToIndex:1] capitalizedString]];
            
            cell.textLabel.text = keyCapitalized;
            cell.detailTextLabel.text = allValues[indexPath.row];
        }
        else {
            cell.textLabel.text = @"None listed";
            cell.detailTextLabel.text = @"";
        }
    }
    else {
        NSArray *array = (NSArray*)self.objects[indexPath.section];
        if([array count] == 0) {
            cell.textLabel.text = @"None listed";
            cell.detailTextLabel.text = @"";
        }
        else {
            cell.textLabel.text = [array[indexPath.row] objectForKey:@"message"];
            cell.detailTextLabel.text = @"";
        }
    }
    
    return cell;
}

#pragma mark - button events

- (IBAction)sendMessageButton:(UIButton*)sender
{
    //[self.navigationController pushViewController:[[MessageViewController alloc] initWithContactID:self.contactID] animated:YES];
}

- (IBAction)wishListButton:(UIButton*)sender
{
    self.wishListButton.selected = !self.wishListButton.selected;
}

#pragma mark - getter and setter

- (NSMutableArray*)objects
{
    if(!_objects)
        _objects = [[NSMutableArray alloc] init];
    return _objects;
}

@end
