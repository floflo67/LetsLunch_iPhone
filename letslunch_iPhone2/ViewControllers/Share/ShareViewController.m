//
//  ShareViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 27/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "ShareViewController.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <FacebookSDK/FacebookSDK.h>
#import "FacebookShare.h"

@interface ShareViewController ()
@property (nonatomic, strong) SLComposeViewController *mySLComposerSheet;
@property (nonatomic, weak) IBOutlet UIButton *facebookButton;
@property (nonatomic, weak) IBOutlet UIButton *twitterButton;
@property (nonatomic, weak) IBOutlet UIButton *linkedinButton;
@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic) BOOL mustShareOnFacebook;
@end

@implementation ShareViewController


static ShareViewController *sharedSingleton = nil;
+ (ShareViewController*)getSingleton
{
    if (sharedSingleton != nil)
        return sharedSingleton;
    @synchronized(self)
    {
        if (sharedSingleton == nil)
            sharedSingleton = [[self alloc] init];
    }
    return sharedSingleton;
}

+ (void)suppressSingleton
{
    if (sharedSingleton != nil)
        sharedSingleton = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.activityIndicator stopAnimating];
}

#pragma mark - Social sharing

- (void)shareOnFacebook
{
    __weak typeof(self) weakSelf = self;
    
    self.mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook]; //Tell him with what social plattform to use it, e.g. facebook or twitter
    [self.mySLComposerSheet setInitialText:@"Test Facebook"/*[NSString stringWithFormat:@"Test", self.mySLComposerSheet.serviceType]*/]; //the message you want to post
    //for more instance methodes, go here:https://developer.apple.com/library/ios/#documentation/NetworkingInternet/Reference/SLComposeViewController_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40012205
    [self presentViewController:self.mySLComposerSheet animated:YES completion:nil];
    
    
    [self.mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        BOOL success = NO;
        NSString *output;
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Action Cancelled";
                break;
            case SLComposeViewControllerResultDone:
                output = @"Post Successfull";
                success = YES;
                break;
            default:
                break;
        }
        
        if(success) {
            weakSelf.facebookButton.alpha = 0.4;
            weakSelf.facebookButton.enabled = NO;
        }
        
        if(weakSelf.mySLComposerSheet) {
            [weakSelf.mySLComposerSheet dismissViewControllerAnimated:YES completion:nil];
            weakSelf.mySLComposerSheet = nil;
        }
    }];
    
    /*
    FacebookShare *facebookShare = [[FacebookShare alloc] init];
    [facebookShare postToFacebook:@"Let's Lunch - iPhone" productLink:@"www.letslunch.com" productImageUrl:@"http://farm6.static.flickr.com/5065/5681696034_e9f67e2181.jpg"];
    self.facebookButton.enabled = NO;
    self.facebookButton.alpha = 0.3;*/
}

- (void)shareOnTwitter
{
    __weak typeof(self) weakSelf = self;
    
    self.mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter]; //Tell him with what social plattform to use it, e.g. facebook or twitter
    [self.mySLComposerSheet setInitialText:@"Test Twitter"/*[NSString stringWithFormat:@"Test", self.mySLComposerSheet.serviceType]*/]; //the message you want to post
    //for more instance methodes, go here:https://developer.apple.com/library/ios/#documentation/NetworkingInternet/Reference/SLComposeViewController_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40012205
    [self presentViewController:self.mySLComposerSheet animated:YES completion:nil];
    
    
    [self.mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        BOOL success = NO;
        NSString *output;
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Action Cancelled";
                break;
            case SLComposeViewControllerResultDone:
                output = @"Post Successfull";
                success = YES;
                break;
            default:
                break;
        }
        
        if(success) {
            weakSelf.twitterButton.alpha = 0.4;
            weakSelf.twitterButton.enabled = NO;
        }
        
        if(weakSelf.mySLComposerSheet) {
            [weakSelf.mySLComposerSheet dismissViewControllerAnimated:YES completion:nil];
            weakSelf.mySLComposerSheet = nil;
        }
    }];
}

- (void)shareOnLinkedIn
{
    NSString *access_token = [AppDelegate getAppDelegate].linkedinToken;
    
    if(!access_token) {
        [self linkedinLogin];
        return;
    }
    
    NSString *urlRequest = [NSString stringWithFormat:@"%@people/~/shares?oauth2_access_token=%@", LK_API_FORMER_URL, access_token];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlRequest]];
    
    NSData *body = [self settingUpParameters];
    [request setHTTPBody:body];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setAllHTTPHeaderFields: @{@"x-li-format":@"json"}];
    [request setHTTPMethod: @"POST"];
    
    NSURLResponse *urlResponse;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:nil];
    
    if([(NSHTTPURLResponse*)urlResponse statusCode] == 201) {
        self.linkedinButton.enabled = NO;
        self.linkedinButton.alpha = 0.4;
    }
    
}

- (NSData*)settingUpParameters
{
    NSData *requestData;
    
    NSString *postTitle = @"postTitle";
    NSString *postDescription = @"postDescription";
    NSString *postURL = @"www.google.com";
    NSString *postImageURL = @"https:////www.google.com//images//srpr//logo4w.png";
    NSString *postComment = @"postComment";
    
    NSMutableDictionary *visibility = [[NSMutableDictionary alloc] init];
    [visibility setValue:@"anyone" forKey:@"code"];
    
    NSMutableDictionary *content = [[NSMutableDictionary alloc] init];
    [content setValue:postTitle forKey:@"title"];
    [content setValue:postDescription forKey:@"description"];
    [content setValue:postURL forKey:@"submitted-url"];
    [content setValue:postImageURL forKey:@"submitted-image-url"];
    
    NSDictionary *update = [[NSDictionary alloc] initWithObjectsAndKeys:visibility, @"visibility", content, @"content", postComment, @"comment", nil];
    
    requestData = [NSJSONSerialization dataWithJSONObject:update options:0 error:nil];
    
    return requestData;
}

#pragma mark - Linkedin login

- (void)linkedinLogin
{
    [self.activityIndicator stopAnimating];
    NSString *urlRequest = [NSString stringWithFormat:@"%@authorization?response_type=code&client_id=%@&state=%@&redirect_uri=%@", LK_API_URL, LK_API_KEY, LK_API_STATE, LK_API_REDIRECT];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlRequest]];
    [self.webView loadRequest:request];
    [self.webView setHidden:NO];
}

#pragma mark - Button events

- (IBAction)facebookButton:(UIButton*)sender
{
    if(!self.facebookButton.selected)
        [self shareOnFacebook];
}

- (IBAction)twitterButton:(UIButton*)sender
{
    if(!self.twitterButton.selected)
        [self shareOnTwitter];
}

- (IBAction)linkedinButton:(UIButton *)sender
{
    if(!self.linkedinButton.selected)
       [self shareOnLinkedIn];
}

- (IBAction)closeButton:(id)sender
{
    [((AppDelegate*)[[UIApplication sharedApplication] delegate]).viewController closeView];
}

- (IBAction)promoteButton:(UIButton*)sender
{
    if(self.mustShareOnFacebook)
        [self shareOnFacebook];
}

#pragma mark - WebView delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
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
                    [self.webView stopLoading];
                    [self.webView removeFromSuperview];
                    self.webView = nil;
                    [self shareOnLinkedIn];
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

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
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
        [[AppDelegate getAppDelegate] setLinkedinToken:[jsonDict objectForKey:@"access_token"]];
    }
    else {
        NSString* error = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", error);
    }
}

#pragma mark - getter and setter

- (SLComposeViewController*)mySLComposerSheet
{
    if(!_mySLComposerSheet)
        _mySLComposerSheet = [[SLComposeViewController alloc] init];
    return _mySLComposerSheet;
}

@end
