//
//  OAuthLoginView.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONKit.h"
#import "OAConsumer.h"
#import "OAMutableURLRequest.h"
#import "OADataFetcher.h"
#import "OATokenManager.h"
#import "Provider.h"

@interface OAuthLoginView : UIViewController <UIWebViewDelegate>
{
    IBOutlet UIWebView *webView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    
    OAToken *requestToken;
    OAToken *accessToken;
    OAConsumer *consumer;
    
    NSDictionary *profile;
}

@property(nonatomic, retain) OAToken *requestToken;
@property(nonatomic, retain) OAToken *accessToken;
@property(nonatomic, retain) NSDictionary *profile;
@property(nonatomic, retain) OAConsumer *consumer;
@property(nonatomic, retain) Provider *provider;

-(void)requestTokenFromProvider;
-(void)allowUserToLogin;
-(void)accessTokenFromProvider;

-(id)initWithLinkedIn;

@end
