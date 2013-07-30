//
//  DetailProfileViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 22/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "DetailProfileViewController.h"
#import "ProfileDetailsRequest.h"

@interface DetailProfileViewController ()
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary* objects;
@end

@implementation DetailProfileViewController

- (id)initWithContactID:(NSString*)contactID
{
    self = [super init];
    if(self) {
        self.objects = (NSMutableDictionary*)[[[ProfileDetailsRequest alloc] init] getProfileWithToken:[AppDelegate getObjectFromKeychainForKey:(__bridge id)(kSecAttrAccount)] andID:contactID];
        
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
    return [_objects count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *keys = [_objects allValues];
    NSArray *subsec = keys[section];
    if([subsec count] > 0)
        return [subsec count];
    else
        return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *keys = [_objects allKeys];
    return keys[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    NSArray *object = [_objects allValues];
    
    if([[object[indexPath.section] class] isSubclassOfClass:[NSDictionary class]]) {
        
        NSArray *keys = [object[indexPath.section] allKeys];
        NSArray *value = [object[indexPath.section] allValues];
        cell.textLabel.text = [keys[indexPath.row] description];
        cell.detailTextLabel.text = [value[indexPath.row] description];        
    }
    else if ([[object[indexPath.section] class] isSubclassOfClass:[NSArray class]]) {
        if([object[indexPath.section] count] > 0) {
            cell.textLabel.text = [object[indexPath.section][indexPath.row] objectForKey:@"name"];
            cell.detailTextLabel.text = @"";
            
        }
        else {        
            cell.textLabel.text = @"None listed";
            cell.detailTextLabel.text = @"";
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - getter and setter

- (NSMutableDictionary *)objects
{
    if(!_objects)
        _objects = [[NSMutableDictionary alloc] init];
    return _objects;
}

@end
