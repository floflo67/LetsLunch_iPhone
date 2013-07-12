//
//  LoginRequests.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 10/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "LoginRequests.h"
#import "AppDelegate.h"
#import "MutableRequest.h"

@implementation LoginRequests

@synthesize delegate = _delegate;

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
    if (_connection == nil) {
		_data = [NSMutableData new];
        
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
        
        _connection = [[NSURLConnection connectionWithRequest:request delegate:self] retain];
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
	if (_connection != nil) {
		[_connection cancel];
		[_connection release];
		_connection = nil;
	}
}

- (void)showErrorMessage:(NSString*)error
{
    [_delegate showErrorMessage:error withErrorStatus:_statusCode];
}

- (void)successfullLoginIn
{
    [_delegate successfullConnection];
}

#pragma connection delegate

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
	[_data appendData:data];
}

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSHTTPURLResponse*)response
{
	_statusCode = [response statusCode];
}

- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    NSLog(@"error");
    
	[_connection release];
	_connection = nil;
	
	[_data release];
	_data = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    NSString* res = [[[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"err: %i, %@",_statusCode, res);
    
	if (_statusCode != 200) {
		NSString* response = [[[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding] autorelease];
        [self showErrorMessage:response];
	}
    else {
        NSDictionary *dictJson = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:_data options:0 error:nil]];
        NSDictionary *dictAuth = [NSDictionary dictionaryWithDictionary:[dictJson objectForKey:@"user"]];
        if([dictAuth count] > 0) {
            NSString* token = [[NSDictionary dictionaryWithDictionary:[dictAuth objectForKey:@"auth"]]objectForKey:@"token"];
            [AppDelegate writeObjectToKeychain:token forKey:kSecAttrAccount];
            [self successfullLoginIn];
        }
        else {
            NSDictionary *dictError = [NSDictionary dictionaryWithDictionary:[dictJson objectForKey:@"error"]];
            NSString* errorMessage = [dictError objectForKey:@"message"];
            _statusCode = [[dictError objectForKey:@"error_status"] integerValue];
            [self showErrorMessage:errorMessage];
        }
	}
	
	[_connection release];
	_connection = nil;
	
	[_data release];
	_data = nil;
}

#pragma lifecycle

- (void)dealloc
{
    [_connection release];
    [_data release];
    [super dealloc];
}

@end
