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
    [textField resignFirstResponder];
    return YES;
}

#pragma button action

- (void)logInWithFacebook
{
    [((AppDelegate*)[UIApplication sharedApplication].delegate) openSession];
}

- (void)logInWithTwitter
{
    /*
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    if (app.token == nil) {
		TwitterLoginViewController* twitterLoginViewController = [[TwitterLoginViewController new] autorelease];
		if (twitterLoginViewController != nil)
		{
			twitterLoginViewController.consumer = app.consumer;
			twitterLoginViewController.delegate = self;
            
			UINavigationController* navigationController = [[[UINavigationController alloc] initWithRootViewController: twitterLoginViewController] autorelease];
			if (navigationController != nil) {
                [self presentViewController:navigationController animated:YES completion:nil];
//				[self presentModalViewController: navigationController animated: YES];
			}
		}
	}
    else {
        [self.view removeFromSuperview];
    }*/
    
    self.isLinkedIn = NO;
    OAuthLoginView* oAuthLoginView = [[OAuthLoginView alloc] initWithTwitter];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.oAuthLoginView = oAuthLoginView;
    
    // register to be told when the login is finished
    [[NSNotificationCenter defaultCenter] addObserver:app selector:@selector(loginViewDidFinish:) name:@"loginViewDidFinish" object:oAuthLoginView];
    [self presentViewController:oAuthLoginView animated:YES completion:nil];
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
