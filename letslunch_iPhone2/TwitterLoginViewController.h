//
//  TwitterLoginViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TwitterAuthenticator.h"

@class TwitterConsumer;
@class TwitterToken;
@class TwitterLoginViewController;

@protocol TwitterLoginViewControllerDelegate
- (void) twitterLoginViewControllerDidCancel: (TwitterLoginViewController*) twitterLoginViewController;
- (void) twitterLoginViewController: (TwitterLoginViewController*) twitterLoginViewController didSucceedWithToken: (TwitterToken*) token;
- (void) twitterLoginViewController: (TwitterLoginViewController*) twitterLoginViewController didFailWithError: (NSError*) error;
@end

@interface TwitterLoginViewController : UIViewController <UITextFieldDelegate,TwitterAuthenticatorDelegate> {
  @private
	TwitterConsumer* _consumer;
    id<TwitterLoginViewControllerDelegate> _delegate;
  @private
	UIBarButtonItem* _loginButton;
	IBOutlet UIView* _containerView;
	IBOutlet UITextField* _usernameTextField;
	IBOutlet UILabel* _usernameLabel;
	IBOutlet UITextField* _passwordTextField;
	IBOutlet UILabel* _passwordLabel;
	IBOutlet UILabel* _statusLabel;
	IBOutlet UIActivityIndicatorView* _activityIndicatorView;
	IBOutlet UIButton* _createAccountButton;
  @private
	TwitterAuthenticator* _authenticator;
}

- (IBAction) cancel;
- (IBAction) login;
- (IBAction) createAccount;

@property (nonatomic,retain) TwitterConsumer* consumer;
@property (nonatomic,assign) id<TwitterLoginViewControllerDelegate> delegate;

@end