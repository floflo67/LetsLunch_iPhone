//
//  LoginViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 27/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

#pragma view life cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
     Sets delegate of UITextField
     */
    self.textFieldPassword.delegate = self;
    self.textFieldUsername.delegate = self;
    
    /*
     Sets action on button click
     */
    [self.buttonFacebook addTarget:self action:@selector(logInWithFacebook) forControlEvents:UIControlEventTouchDown];
    [self.buttonTwitter addTarget:self action:@selector(logInWithTwitter) forControlEvents:UIControlEventTouchDown];
    [self.buttonLinkedIn addTarget:self action:@selector(logInWithLinkedIn) forControlEvents:UIControlEventTouchDown];
    [self.buttonLogIn addTarget:self action:@selector(buttonLogInClick) forControlEvents:UIControlEventTouchDown];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_textFieldUsername release];
    [_textFieldPassword release];
    [_buttonLogIn release];
    [_buttonTwitter release];
    [_buttonFacebook release];
    [_buttonLinkedIn release];
    [super dealloc];
}

#pragma text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
    [textField resignFirstResponder];
    return YES;
}

#pragma button action

- (void)logInWithFacebook
{
    [((AppDelegate*)[UIApplication sharedApplication].delegate) openSession];
    /*
    bool success = YES;
    NSLog(@"Facebook: %d", success);
    return success;
    */
}

- (BOOL)logInWithTwitter
{
    bool success = YES;
    NSLog(@"Twitter: %d", success);
    return success;
}

- (BOOL)logInWithLinkedIn
{
    bool success = YES;
    NSLog(@"LinkedIn: %d", success);
    return success;
}

- (BOOL)buttonLogInClick
{
    return [self logInWithUsername:self.textFieldUsername.text andPassword:self.textFieldPassword.text];
}

- (BOOL)logInWithUsername:(NSString*)username andPassword:(NSString*)password
{
    bool success = NO;
    
    if([username isEqualToString:@"Florian"])
        if([password isEqualToString:@"Password"])
            success = YES;
    
    NSLog(@"%d", success);
    return success;
}

@end
