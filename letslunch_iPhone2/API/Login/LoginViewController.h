//
//  LoginViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 27/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginRequests.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate, LoginRequestDelegate>


-(void)logInWithFacebook;
-(void)logInWithTwitter;
-(void)logInWithLinkedIn;
-(BOOL)buttonLogInClick;
-(BOOL)logInWithUsername:(NSString*)username andPassword:(NSString*)password;

@end
