//
//  ProfileViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 11/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileRequest.h"

@interface ProfileViewController ()
@property (nonatomic, strong) ProfileRequest *profileRequest;
@property (nonatomic, strong) NSMutableArray* objects;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ProfileViewController

static ProfileViewController *sharedSingleton = nil;
+ (ProfileViewController*)getSingleton
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
    NSString *token = [AppDelegate getToken];
    if (self) {
        NSDictionary *dict = [[[ProfileRequest alloc] init] getProfileWithToken:token andLight:NO];
        
        NSMutableDictionary *profile = [NSMutableDictionary dictionaryWithDictionary:[dict objectForKey:@"profile"]];
        [profile removeObjectForKey:@"uid"];
        
        NSDictionary *location = [NSDictionary dictionaryWithDictionary:[dict objectForKey:@"location"]];
        NSDictionary *other = [NSDictionary dictionaryWithDictionary:[dict objectForKey:@"other"]];
        NSDictionary *skills = [NSArray arrayWithArray:[dict objectForKey:@"skills"]];
        NSDictionary *needs = [NSArray arrayWithArray:[dict objectForKey:@"needs"]];
        
        self.objects = (NSMutableArray*)@[profile, location, other, skills, needs];
    }
    
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    NSInteger number = [self.objects count];
    return number;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = [(NSArray*)self.objects[section] count];
    if(number == 0)
        number++;
    return number;
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
        
        NSString *key = allKeys[indexPath.row];
        NSString *keyCapitalized = [key stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[key substringToIndex:1] capitalizedString]];
        
        cell.textLabel.text = keyCapitalized;
        cell.detailTextLabel.text = allValues[indexPath.row];
    }
    else {
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
    return cell;
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
        default:
            return @"";
            break;
    }
}

#pragma mark - getter and setter

- (NSMutableArray*)objects
{
    if(!_objects)
        _objects = [[NSMutableArray alloc] init];
    return _objects;
}

@end
