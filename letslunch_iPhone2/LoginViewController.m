//
//  LoginViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 27/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "OAuthLoginView.h"
#import "TwitterLoginViewController.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

#pragma view life cycle

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

- (void)dealloc
{
    [_textFieldUsername release];
    [_textFieldPassword release];
    [_buttonLogIn release];
    [_buttonTwitter release];
    [_buttonFacebook release];
    [_buttonLinkedIn release];
    [super dealloc];
}

#pragma twitterLoginViewController delegate

- (void)twitterLoginViewControllerDidCancel:(TwitterLoginViewController*)twitterLoginViewController
{
    [twitterLoginViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)twitterLoginViewController:(TwitterLoginViewController*)twitterLoginViewController didSucceedWithToken:(TwitterToken*)token
{
	_token = [token retain];
    
	// Save the token to the user defaults
	[[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject: _token] forKey:@"Token"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)twitterLoginViewController:(TwitterLoginViewController*)twitterLoginViewController didFailWithError:(NSError*)error
{
	NSLog(@"twitterLoginViewController: %@ didFailWithError: %@", self, error);
}

#pragma text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.textFieldUsername) {
        [textField resignFirstResponder];
        [self.textFieldPassword becomeFirstResponder];
    }
    else if (textField == self.textFieldPassword) {
        [textField resignFirstResponder];
        [self buttonLogInClick];
    }
    return YES;
}

#pragma button action

- (void)logInWithFacebook
{
    ACAccountStore* store = [[ACAccountStore alloc] init];
    ACAccountType* facebookAccountType = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    
    NSArray* objects = [NSArray arrayWithObjects:FB_OAUTH_KEY,@[@"publish_stream"],ACFacebookAudienceEveryone, nil];
    NSArray* keys = [NSArray arrayWithObjects:ACFacebookAppIdKey,ACFacebookPermissionsKey,ACFacebookAudienceKey, nil];
    NSDictionary* options = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    
    
    [store requestAccessToAccountsWithType:facebookAccountType options:options completion:^void(BOOL granted, NSError* error) {
        NSArray* facebookAccounts = [store accountsWithAccountType:facebookAccountType];
        if([facebookAccounts count] > 0)
        {
            ACAccount* account = [facebookAccounts objectAtIndex:0];
            NSLog(@"%@", account.username);
        }
        else {
            [((AppDelegate*)[UIApplication sharedApplication].delegate) openSession];
        }
    }];
}

- (void)logInWithTwitter
{
    ACAccountStore* store = [[ACAccountStore alloc] init];
    ACAccountType* twitterAccountType = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [store requestAccessToAccountsWithType:twitterAccountType options:nil completion:^void(BOOL granted, NSError* error) {
        NSArray* twitterAccounts = [store accountsWithAccountType:twitterAccountType];
        if(twitterAccounts && [twitterAccounts count] > 0)
        {
            ACAccount* account = [twitterAccounts objectAtIndex:0];
            NSLog(@"%@", account.username);
        }
        else {
            NSLog(@"No accounts");
            /*
            self.isLinkedIn = NO;
            OAuthLoginView* oAuthLoginView = [[OAuthLoginView alloc] initWithTwitter];
            AppDelegate *app = [UIApplication sharedApplication].delegate;
            app.oAuthLoginView = oAuthLoginView;
            
            // register to be told when the login is finished
            [[NSNotificationCenter defaultCenter] addObserver:app selector:@selector(loginViewDidFinish:) name:@"loginViewDidFinish" object:oAuthLoginView];
            [self presentViewController:oAuthLoginView animated:YES completion:nil];
            */
        }
    }];
}

- (void)logInWithLinkedIn
{
    self.isLinkedIn = YES;
    OAuthLoginView* oAuthLoginView = [[OAuthLoginView alloc] initWithLinkedIn];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.oAuthLoginView = oAuthLoginView;
    
    // register to be told when the login is finished
    [[NSNotificationCenter defaultCenter] addObserver:app selector:@selector(loginViewDidFinish:) name:@"loginViewDidFinish" object:oAuthLoginView];
    [self presentViewController:oAuthLoginView animated:YES completion:nil];
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
