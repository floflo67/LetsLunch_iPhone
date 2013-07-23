//
//  ProfileViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 11/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize profileRequest = _profileRequest;

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
    NSString *token = [AppDelegate getObjectFromKeychainForKey:kSecAttrAccount];
    if (self) {        
        if(!_profileRequest)
            _profileRequest = [[ProfileRequest alloc] init];
        
        NSDictionary *dict = [_profileRequest getProfileWithToken:token];
        
        NSMutableDictionary *profile = [NSMutableDictionary dictionaryWithDictionary:[dict objectForKey:@"profile"]];
        [profile removeObjectForKey:@"uid"];
        
        NSDictionary *location = [NSDictionary dictionaryWithDictionary:[dict objectForKey:@"location"]];
        NSDictionary *other = [NSDictionary dictionaryWithDictionary:[dict objectForKey:@"other"]];
        
        _objects = [[NSMutableArray alloc] initWithObjects:profile, location, other, nil];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_objects release];
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger number = [_objects count];
    return number;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = [(NSArray*)_objects[section] count];
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    NSDictionary *dict = (NSDictionary*)_objects[indexPath.section];
    
    NSArray *allKeys = [dict allKeys];
    NSArray *allValues = [dict allValues];
    
    cell.textLabel.text = allKeys[indexPath.row];
    cell.detailTextLabel.text = allValues[indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
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
        default:
            return @"";
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == 2)
        return 100;
    else
        return 10;
}

@end
