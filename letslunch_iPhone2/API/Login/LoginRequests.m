//
//  LoginRequests.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 10/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "LoginRequests.h"
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
	if (_statusCode != 200) {
        NSDictionary *dictJson = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:_data options:0 error:nil]];
        NSDictionary *dictError = [NSDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithDictionary:[dictJson objectForKey:@"error"]]];
		NSString* response = [dictError objectForKey:@"message"];
        [self showErrorMessage:response];
	}
    else {
        NSDictionary *dictJson = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:_data options:0 error:nil]];
        NSDictionary *dictAuth = [NSDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithDictionary:[dictJson objectForKey:@"user"]]];
        NSString* token = [dictAuth objectForKey:@"token"];
        NSString *pictureURLString = [dictAuth objectForKey:@"picture_url"];
        [AppDelegate writeObjectToKeychain:token forKey:kSecAttrAccount];
        if(pictureURLString && ![pictureURLString isEqualToString:@""])
            [AppDelegate writeObjectToKeychain:pictureURLString forKey:kSecAttrDescription];
        [self successfullLoginIn];
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
