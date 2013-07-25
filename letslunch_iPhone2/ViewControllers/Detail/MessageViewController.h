//
//  MessageViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray* objects;
@property (nonatomic, strong) NSString *contactID;

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *textFieldMessage;

-(id)initWithContactID:(NSString*)contactID;
-(BOOL)textFieldShouldReturn:(UITextField *)textField;
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField;

@end
