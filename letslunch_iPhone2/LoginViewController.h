//
//  LoginViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 27/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *textFieldUsername;
@property (retain, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (retain, nonatomic) IBOutlet UIButton *buttonLogIn;
@property (retain, nonatomic) IBOutlet UIButton *buttonTwitter;
@property (retain, nonatomic) IBOutlet UIButton *buttonFacebook;

-(BOOL)logInWithFacebook;
-(BOOL)logInWithTwitter;
-(BOOL)buttonLogInClick;
-(BOOL)logInWithUsername:(NSString*)username andPassword:(NSString*)password;

@end
