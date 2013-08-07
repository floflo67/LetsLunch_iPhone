//
//  LoginRequests.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 10/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "LoginRequests.h"
#import "MutableRequest.h"

@interface LoginRequests()
@property (nonatomic, strong) NSURLConnection* connection;
@property (nonatomic, strong) NSMutableData* data;
@property (nonatomic) NSInteger statusCode;
@end

@implementation LoginRequests

/*
 URL: http://letslunch.dev.knackforge.com/api/login
 Request Type: POST
 Parameters:
    username (Email id)
    password
    deviceId (Iphone device ID)
 */
- (BOOL)loginWithUserName:(NSString*)username andPassword:(NSString*)password
{
    if (self.connection == nil) {
        
        /*
         Sets the body of the requests
         Countains username, password and device ID
         */
        NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
        [parameters setValue:username forKey:@"username"];
        [parameters setValue:password forKey:@"password"];
        [parameters setValue:[[UIDevice currentDevice] identifierForVendor] forKey:@"deviceId"];
        [parameters setValue:@"0" forKey:@"rememberMe"];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@login",LL_API_BaseUrl]];
        MutableRequest *request = [[MutableRequest alloc] initWithURL:url andParameters:parameters andType:@"POST"];
        
        self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    }
    return YES;
}

/*
 URL:  http://letslunch.dev.knackforge.com/api/signUp
 Request Type: POST
 Parameters:
    name
    email
    password
    country (example: "us")
 */
- (BOOL)signUpWithUserName:(NSString*)username andPassword:(NSString*)password andMailAddress:(NSString*)email andCountry:(NSString*)country
{
    return YES;
}

- (void)cancel
{
	if (self.connection != nil) {
		[self.connection cancel];
		self.connection = nil;
	}
}

- (void)showErrorMessage:(NSString*)error
{
    [AppDelegate showErrorMessage:error withErrorStatus:self.statusCode];
}

- (void)successfullLoginIn
{
    [((AppDelegate*)[UIApplication sharedApplication].delegate) loginSuccessfull];
}

#pragma connection delegate

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
	[self.data appendData:data];
}

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSHTTPURLResponse*)response
{
	self.statusCode = [response statusCode];
}

- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    [AppDelegate showNoConnectionMessage];
    NSLog(@"error");
	self.connection = nil;
	self.data = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection
{
	if (self.statusCode != 200) {
        NSDictionary *dictJson = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:self.data options:0 error:nil]];
        NSDictionary *dictError = [NSDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithDictionary:[dictJson objectForKey:@"error"]]];
		NSString* response = [dictError objectForKey:@"message"];
        [self showErrorMessage:response];
	}
    else {
        NSDictionary *dictJson = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:self.data options:0 error:nil]];
        NSDictionary *dictAuth = [NSDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithDictionary:[dictJson objectForKey:@"user"]]];
        NSString* token = [dictAuth objectForKey:@"token"];
        [AppDelegate writeObjectToKeychain:token forKey:(__bridge id)(kSecAttrAccount)];
        [self successfullLoginIn];
	}
	self.connection = nil;
	self.data = nil;
}

#pragma getter and setter

- (NSMutableData*)data
{
    if(!_data)
        _data = [NSMutableData new];
    return _data;
}


@end
