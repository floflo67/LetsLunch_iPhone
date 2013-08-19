//
//  MessageViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "MessageViewController.h"
#import "Messages.h"
#import "ThreadCell.h"
#import "MessageRequest.h"

@interface MessageViewController ()

@property (nonatomic, strong) NSMutableArray* objects;
@property (nonatomic, strong) NSString *threadID;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UITextField *textFieldMessage;

@end

@implementation MessageViewController

#pragma mark - view lifecycle

- (id)initWithThreadID:(NSString*)threadID
{
    self = [super init];
    if(self) {
        self.threadID = threadID;
        self.objects = [(AppDelegate*)[[UIApplication sharedApplication] delegate] getListMessagesForThreadID:self.threadID];
        if([self.objects count] == 0) // if no messages
            return nil; // avoid push since nil
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
    self.tableView.frame = CGRectMake(0, 0, 320, 500);
    
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

- (void)viewDidAppear:(BOOL)animated
{
    /*
     Scrolls to last message -> bottom of page
     */
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:[_objects count] - 1];
    [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    [super viewDidAppear:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return [_objects count]; // one section per message
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ThreadCell *cell = (ThreadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ThreadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Messages *mess = _objects[indexPath.section];
    
    /*
     Message sent by user
     */
    if([mess.contactID isEqualToString:self.threadID])
        [cell setImageName:@"MessageFromSelf.png" andTipRightward:NO];
    /*
     Message sent to user
     */
    else
        [cell setImageName:@"MessageToSelf.png" andTipRightward:YES];
    
    /*
     Changes format of date to hour:minute for message
     */
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"hh:mm a"];
    
    [cell setMessage:[mess description] andDate:[format stringFromDate:mess.date]];
    
    mess = nil;
    format = nil;
    
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
	NSString *aMsg = [[_objects objectAtIndex:indexPath.section] description];
    CGFloat widthForText = 260.f;    
	CGSize size = [ThreadCell calcTextHeight:aMsg withinWidth:widthForText];	
	return size.height - 5;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
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
    
    format = nil;
    
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

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if(textField.isFirstResponder) {
        [textField resignFirstResponder];
        [self changeTextFieldFrame:NO];
        NSString *message = self.textFieldMessage.text;
        self.textFieldMessage.text = @""; // clears message
        
        if(message && ![message isEqualToString:@""])
            [MessageRequest sendMessage:message withToken:[AppDelegate getToken] toThread:self.threadID];
        
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField*)textField
{
    if(!textField.isFirstResponder) {
        [textField isFirstResponder];
        [self changeTextFieldFrame:YES];
    }
    return YES;
}

/*
 Moves the origin of the textField
 isBeginning = YES -> Keyboard appears
 */
- (void)changeTextFieldFrame:(bool)isBeginning
{
    int y = 215;
    CGRect frame = self.textFieldMessage.frame;
    if(isBeginning)
        frame.origin.y -= y;
    else
        frame.origin.y += y;
    self.textFieldMessage.frame = frame;
}

#pragma mark - getter and setter

- (NSMutableArray*)objects
{
    if(!_objects)
        _objects = [[NSMutableArray alloc] init];
    return _objects;
}

@end
