//
//  LoginViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 27/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "LoginViewController.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import "LoginRequests.h"

@interface LoginViewController ()

@property (nonatomic, weak) IBOutlet UITextField *textFieldUsername;
@property (nonatomic, weak) IBOutlet UITextField *textFieldPassword;
@property (nonatomic, weak) IBOutlet UIButton *buttonTwitter;
@property (nonatomic, weak) IBOutlet UIButton *buttonFacebook;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic) BOOL isLinkedIn;
@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation LoginViewController

#pragma mark - view life cycle

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
    
    [self.activityIndicator stopAnimating];
}

#pragma mark - text field delegate

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if(textField == self.textFieldUsername) {
        [textField resignFirstResponder];
        [self.textFieldPassword becomeFirstResponder];
    }
    else if (textField == self.textFieldPassword) {
        [textField resignFirstResponder];
        [self loginButton:nil];
    }
    return YES;
}

#pragma mark - button action

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
            NSLog(@"%@", account);
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
            NSLog(@"%@", account);
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

#pragma mark - button events

- (IBAction)loginButton:(UIButton*)sender
{
    [self logInWithUsername:self.textFieldUsername.text andPassword:self.textFieldPassword.text];
}

- (IBAction)linkedinButton:(UIButton *)sender
{
    [self.activityIndicator stopAnimating];
    NSString *urlRequest = [NSString stringWithFormat:@"%@authorization?response_type=code&client_id=%@&state=%@&redirect_uri=%@", LK_API_URL, LK_API_KEY, LK_API_STATE, LK_API_REDIRECT];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlRequest]];
    [self.webView loadRequest:request];
    [self.webView setHidden:NO];
    
    //LinkedInViewController *linkedinViewController = [[LinkedInViewController alloc] init];
    //[self.view addSubview:linkedinViewController.view];
    
}

#pragma mark - WebView delegate

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
	NSURL *url = request.URL;
	NSString *urlString = url.absoluteString;
    BOOL requestForCallbackURL = ([urlString rangeOfString:[NSString stringWithFormat:@"%@?", LK_API_REDIRECT]].location != NSNotFound); // YES if success
    BOOL userSubmit = ([urlString rangeOfString:@"submit"].location != NSNotFound); // YES if success
    if (requestForCallbackURL && !userSubmit) {
        BOOL userAllowedAccess = ([urlString rangeOfString:@"error"].location == NSNotFound); // YES if success
        BOOL correctState = [urlString rangeOfString:LK_API_STATE].location != NSNotFound; // YES if success
        
        if (userAllowedAccess && correctState) {
            NSString *authorizationCode = [self getAuthorizationCodeWithRequestString:urlString];
            if(authorizationCode && ![authorizationCode isEqualToString:@""]) {
                if([self requestAccesWithCode:authorizationCode]) {
                    [AppDelegate writeObjectToKeychain:self.access_token forKey:(__bridge id)(kSecAttrAccount)];
                    [self.webView stopLoading];
                    self.webView = nil;
                    [self.view removeFromSuperview];
                    [((AppDelegate*)[UIApplication sharedApplication].delegate) loginSuccessfull];
                }
            }
        }
        else if(!userAllowedAccess) {
            NSLog(@"User cancelled");
            [self.webView setHidden:YES];
            return NO;
        }
        else {
            NSLog(@"Error");
        }
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView*)webView
{
    [self.activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView*)webView
{
    [self.activityIndicator stopAnimating];
}

# pragma mark - Request delegate

- (BOOL)requestAccesWithCode:(NSString*)authorizationCode
{
    NSString *urlRequest = [NSString stringWithFormat:@"%@accessToken?grant_type=authorization_code&code=%@&redirect_uri=%@&client_id=%@&client_secret=%@", LK_API_URL, authorizationCode,LK_API_REDIRECT, LK_API_KEY, LK_API_SECRET];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlRequest]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-Type"];
    
    NSURLResponse *response;
    
    [self.activityIndicator startAnimating];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    [self settingUpData:data andResponse:response];
    [self.activityIndicator stopAnimating];
    
    return YES;
}

#pragma mark - Custom functions

- (NSString*)getAuthorizationCodeWithRequestString:(NSString*)urlString
{
    int lenght = [LK_API_REDIRECT length];
    if([LK_API_REDIRECT hasSuffix:@"/"])
        lenght++;
    NSString *parameters = [urlString substringFromIndex:lenght];
    NSArray *pairs = [parameters componentsSeparatedByString:@"&"];
    NSString *auth = @"";
    
	for (NSString *pair in pairs)
    {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        if ([[elements objectAtIndex:0] isEqualToString:@"code"])
        {
            auth = [elements objectAtIndex:1];
        }
    }
    return auth;
}

- (void)settingUpData:(NSData*)data andResponse:(NSURLResponse*)response
{
    NSInteger statusCode = [(NSHTTPURLResponse*)response statusCode];
    
    if(statusCode == 200) {
        NSMutableDictionary *jsonDict = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        self.access_token = [jsonDict objectForKey:@"access_token"];
    }
    else {
        NSString* error = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%i: %@", statusCode, error);
    }
}

#pragma mark - API call

- (BOOL)logInWithUsername:(NSString*)username andPassword:(NSString*)password
{
    /*
    username = @"florian@letslunch.com";
    password = @"developer";*/
    return [[[LoginRequests alloc] init] loginWithUserName:username andPassword:password];
}

@end
