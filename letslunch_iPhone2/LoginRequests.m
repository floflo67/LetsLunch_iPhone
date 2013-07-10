//
//  LoginRequests.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 10/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "LoginRequests.h"

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
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@login",LL_API_BaseUrl]]];
        NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:@"admin", @"X_REST_USERNAME", @"admin", @"X_REST_PASSWORD", nil];
        
        /*
         Sets the body of the requests
         Countains username, password and device ID
         */
        NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
        
        [parameters setValue:username forKey:@"username"];
        [parameters setValue:password forKey:@"password"];
        [parameters setValue:[[UIDevice currentDevice] identifierForVendor] forKey:@"deviceId"];
        [parameters setValue:@"0" forKey:@"rememberMe"];
        
        /*
         Normalize all parameters
         */
        NSMutableString* normalizedRequestParameters = [NSMutableString string];
        for (NSString* key in [[parameters allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)])
        {
            if ([normalizedRequestParameters length] != 0) {
                [normalizedRequestParameters appendString: @"&"];
            }
            
            [normalizedRequestParameters appendString:key];
            [normalizedRequestParameters appendString:@"="];
            if(![key isEqualToString:@"deviceId"])
                [normalizedRequestParameters appendString:[self _formEncodeString:[parameters objectForKey:key]]];
            else {
                NSMutableString *deviceID = [NSString stringWithFormat:@"%@",[parameters objectForKey:@"deviceId"]];
                deviceID = (NSMutableString*)[deviceID substringFromIndex:29];
                [normalizedRequestParameters appendString:deviceID];
            }
        }
        
        NSData* requestData = [normalizedRequestParameters dataUsingEncoding:NSUTF8StringEncoding];
        
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:requestData];
        [request setValue:[NSString stringWithFormat: @"%d", [requestData length]] forHTTPHeaderField: @"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-Type"];
        [request setAllHTTPHeaderFields:headers];
        
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

#pragma special functions

/*
 Change special characters to avoir errors
 Adding an escape to make it as a special character
 */
- (NSString*)_formEncodeString:(NSString*)string
{
	NSString* encoded = (NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef) string, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8);
	return [encoded autorelease];
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
		NSString* response = [[[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding] autorelease];
        [self showErrorMessage:response];
	}
    else {
        NSDictionary *dictJson = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:_data options:0 error:nil]];
        NSDictionary *dictAuth = [NSDictionary dictionaryWithDictionary:[dictJson objectForKey:@"user"]];
        NSLog(@"%@", dictJson);
        if([dictAuth count] > 0) {
            NSString* token = [[NSDictionary dictionaryWithDictionary:[dictAuth objectForKey:@"auth"]]objectForKey:@"token"];
            NSLog(@"%@",token);
        }
        else {
            NSDictionary *dictError = [NSDictionary dictionaryWithDictionary:[dictJson objectForKey:@"data"]];
            NSString* errorMessage = [dictJson objectForKey:@"message"];
            _statusCode = [[dictError objectForKey:@"errorCode"] integerValue];
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
