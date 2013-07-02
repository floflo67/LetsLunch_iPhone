//
//  OAuthLoginView.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/NSNotificationQueue.h>
#import "OAuthLoginView.h"


#define API_KEY_LENGTH 12
#define SECRET_KEY_LENGTH 16

//
// OAuth steps for version 1.0a:
//
//  1. Request a "request token"
//  2. Show the user a browser with the LinkedIn login page
//  3. LinkedIn redirects the browser to our callback URL
//  4  Request an "access token"
//
@implementation OAuthLoginView
@synthesize requestToken, accessToken, profile, consumer, provider;

#pragma view life cycle

- (id)init
{
    self = [super init];
    if(self) {
        
    }
    return self;
}

- (id)initWithLinkedIn
{
    self = [super init];
    if(self) {
        provider = [[Provider alloc] initWithLinkedIn];
        self.consumer = [[OAConsumer alloc] initWithKey:provider.apikey secret:provider.secretkey realm:@"http://api.linkedin.com/"];
        addressBar.text = @"www.linkedin.com/uas/oauth/authorize";
    }
    return self;
}

- (id)initWithTwitter
{
    self = [super init];
    if(self) {
        provider = [[Provider alloc] initWithTwitter];
        self.consumer = [[OAConsumer alloc] initWithKey:provider.apikey secret:provider.secretkey realm:@"http://api.twitter.com/"];
        addressBar.text = @"www.api.twitter.com/oauth/authenticate";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [addressBar setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self requestTokenFromProvider];
}

#pragma webview and API

/*
 OAuth step 1a:
 Make a request for a "request token".
 */
- (void)requestTokenFromProvider
{
    OAMutableURLRequest *request = [[[OAMutableURLRequest alloc] initWithURL:provider.requestTokenURL consumer:self.consumer token:nil callback:provider.callbackURL signatureProvider:nil] autorelease];
    
    [request setHTTPMethod:@"POST"];   
    
    OARequestParameter *nameParam = [[OARequestParameter alloc] initWithName:@"scope" value:@"r_basicprofile+rw_nus"];
    [request setParameters:[NSArray arrayWithObjects:nameParam, nil]];
    
    OARequestParameter *scopeParameter=[OARequestParameter requestParameter:@"scope" value:@"r_fullprofile rw_nus"];
    [request setParameters:[NSArray arrayWithObject:scopeParameter]];
    
    OADataFetcher *fetcher = [[[OADataFetcher alloc] init] autorelease];
    [fetcher fetchDataWithRequest:request delegate:self didFinishSelector:@selector(requestTokenResult:didFinish:) didFailSelector:@selector(requestTokenResult:didFail:)];
}

/*
 OAuth step 1b:
 Called only if successfully received a request token
 Shows webview with login page
 */
- (void)requestTokenResult:(OAServiceTicket*)ticket didFinish:(NSData*)data 
{
    if (ticket.didSucceed == NO) {
        NSLog(@"error");
        return;
    }
    
    NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    self.requestToken = [[OAToken alloc] initWithHTTPResponseBody:responseBody];
    [responseBody release];
    [self allowUserToLogin];
}

- (void)requestTokenResult:(OAServiceTicket*)ticket didFail:(NSData*)error 
{
    NSLog(@"%@",[error description]);
}

/*
 OAuth step 2:
 Displays login page as browser
 */
- (void)allowUserToLogin
{
    NSString *userLoginURLWithToken = [NSString stringWithFormat:@"%@?oauth_token=%@", provider.userLoginURLString, self.requestToken.key];
    
    provider.userLoginURL = [NSURL URLWithString:userLoginURLWithToken];
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:provider.userLoginURL];
    [webView loadRequest:request];     
}

/*
 OAuth step 3:
 Method when loading, happens 3 times:
    a) Our own [webView loadRequest] message sends the user to the login page.
    b) The user types in their username/password and presses 'OK'
    c) Response to the submit request by redirecting the browser to our callback URL
        If the user approves they also add two parameters to the callback URL: oauth_token and oauth_verifier
        If the user does not allow access the parameter user_refused is returned

 */
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType 
{
	NSURL *url = request.URL;
	NSString *urlString = url.absoluteString;
    
    addressBar.text = urlString;
    [activityIndicator startAnimating];
    
    BOOL requestForCallbackURL = ([urlString rangeOfString:provider.callbackURL].location != NSNotFound);
    if (requestForCallbackURL) {
        BOOL userAllowedAccess = ([urlString rangeOfString:@"user_refused"].location == NSNotFound);
        if (userAllowedAccess) {            
            [self.requestToken setVerifierWithUrl:url];
            [self accessTokenFromProvider];
        }
        else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginViewDidFinish" object:self userInfo:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    else {
        // Case (a) or (b), so ignore it
    }
	return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicator stopAnimating];
}

//
// OAuth step 4:
//
- (void)accessTokenFromProvider
{ 
    OAMutableURLRequest *request = [[[OAMutableURLRequest alloc] initWithURL:provider.accessTokenURL consumer:self.consumer token:self.requestToken callback:nil signatureProvider:nil] autorelease];
    
    [request setHTTPMethod:@"POST"];
    OADataFetcher *fetcher = [[[OADataFetcher alloc] init] autorelease];
    [fetcher fetchDataWithRequest:request delegate:self didFinishSelector:@selector(accessTokenResult:didFinish:) didFailSelector:@selector(accessTokenResult:didFail:)];    
}

- (void)accessTokenResult:(OAServiceTicket *)ticket didFinish:(NSData *)data 
{
    NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    BOOL problem = ([responseBody rangeOfString:@"oauth_problem"].location != NSNotFound);
    if (problem) {
        NSLog(@"Request access token failed.");
        NSLog(@"%@",responseBody);
    }
    else {
        self.accessToken = [[OAToken alloc] initWithHTTPResponseBody:responseBody];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginViewDidFinish" object:self];
    [self dismissViewControllerAnimated:YES completion:nil];
    [responseBody release];
}

@end
