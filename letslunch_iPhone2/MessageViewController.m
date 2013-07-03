//
//  MessageViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "MessageViewController.h"
#import "AppDelegate.h"
#import "Messages.h"
#import "ThreadCell.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

#pragma view lifecycle

-(id)init
{
    self = [super init];
    if(self) {
        
        /*
         Default that should be changed later
         */
        if(!_objects) {
            _objects = [[NSMutableArray alloc] initWithArray:[(AppDelegate*)[[UIApplication sharedApplication] delegate] getListMessagesForContactID:@"1" andForceReload:NO]];
        }
    }
    return self;
}

- (id)initWithContactID:(NSString*)contactID
{
    self = [super init];
    if(self) {
        if(!_objects) {
            self.contactID = contactID;
            _objects = [[NSMutableArray alloc] initWithArray:[(AppDelegate*)[[UIApplication sharedApplication] delegate] getListMessagesForContactID:contactID andForceReload:NO]];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Messages";
    
    /*
     Changes frame of tableView
     */
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.frame = CGRectMake(0, 0, 320, 385);
    
    /*
     Changes frame of textField
     Appears bottom of view
     Should add an ImageView as a background later?
     Sets delegate as self
     */
    CGRect frame = self.textFieldMessage.frame;
    frame.origin.y = 385;
    self.textFieldMessage.frame = frame;
    self.textFieldMessage.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    _objects = nil;
    _tableView = nil;
    _contactID = nil;
    _textFieldMessage = nil;
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_objects count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ThreadCell *cell = (ThreadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ThreadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Messages *mess = _objects[indexPath.section];
    
    /*
     Message sent by user
     */
    if([mess.contactIDFrom isEqualToString:self.contactID]) {
        cell.imgName = @"MessageFromSelf.png";
        cell.tipRightward = NO;
    }
    /*
     Message sent to user
     */
    else {
        cell.imgName = @"MessageToSelf.png";
        cell.tipRightward = YES;
    }
    
    cell.msgText = [mess description];
    
    /*
     Changes format of date to hour:minute for message
     */
    NSDateFormatter *format = [[[NSDateFormatter alloc] init] autorelease];
    [format setDateFormat:@"hh:mm"];
    cell.dateText = [format stringFromDate:mess.date];
    mess = nil;
    format = nil;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *aMsg = [[_objects objectAtIndex:indexPath.section] description];
    CGFloat widthForText = 260.f;    
	CGSize size = [ThreadCell calcTextHeight:aMsg withinWidth:widthForText];	
	return size.height - 5;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    /*
     Header appears only if change of date between two messages
     Header is date of message (Month/Day/Year)
     */
    NSString *title;
    Messages *mess1 = (Messages*)_objects[section];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyyy"];
    
    if(section > 0) {
        Messages *mess2 = (Messages*)_objects[section - 1];
        
        if(![self isSameDayWithDate1:mess1.date date2:mess2.date]) {
            title = [format stringFromDate:mess1.date];
        }
        else {
            title = nil;
        }
    }
    else {
        title = [format stringFromDate:mess1.date];
    }
    
    return title;
}

/*
 Checks if two dates are the same day
 if day, month and year are the same
 */
- (BOOL)isSameDayWithDate1:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day] == [comp2 day] && [comp1 month] == [comp2 month] && [comp1 year] == [comp2 year];
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self changeTextFieldFrame:NO];
    NSLog(@"%@", self.textFieldMessage.text); // will push to API once exists
    self.textFieldMessage.text = @""; // clears message
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self changeTextFieldFrame:YES];
    return YES;
}

/*
 Moves the origin of the textField
 isBeginning = YES -> Keyboard appears
 */
- (void)changeTextFieldFrame:(bool)isBeginning
{
    int y = 105;
    CGRect frame = self.textFieldMessage.frame;
    if(isBeginning)
        frame.origin.y -= y;
    else
        frame.origin.y += y;
    self.textFieldMessage.frame = frame;
}

@end
