//
//  LoginViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 27/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginRequests.h"

@class LoginRequests;

@interface LoginViewController : UIViewController <UITextFieldDelegate, LoginRequestDelegate> {
    @private
        LoginRequests *_loginRequest;
}

@property (strong, nonatomic) IBOutlet UITextField *textFieldUsername;
@property (strong, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (strong, nonatomic) IBOutlet UIButton *buttonLogIn;
@property (strong, nonatomic) IBOutlet UIButton *buttonTwitter;
@property (strong, nonatomic) IBOutlet UIButton *buttonFacebook;
@property (strong, nonatomic) IBOutlet UIButton *buttonLinkedIn;
@property (nonatomic) BOOL isLinkedIn;


-(void)logInWithFacebook;
-(void)logInWithTwitter;
-(void)logInWithLinkedIn;
-(BOOL)buttonLogInClick;
-(BOOL)logInWithUsername:(NSString*)username andPassword:(NSString*)password;

@end
