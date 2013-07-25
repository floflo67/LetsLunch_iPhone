//
//  ProfileRequest.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 11/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "ProfileRequest.h"
#import "MutableRequest.h"

@implementation ProfileRequest

+ (NSDictionary*)getProfileWithToken:(NSString*)token
{
    ProfileRequest *profileRequest = [[ProfileRequest alloc] init];
    return [profileRequest getProfileWithToken:token];
}

/*
 URL: http://letslunch.dev.knackforge.com/api/me
 Request Type: POST
 Parameters:
    authToken (Email id)
 */
- (NSDictionary*)getProfileWithToken:(NSString*)token
{
    /*
     Sets the body of the requests
     Countains username, password and device ID
     */
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:token forKey:@"authToken"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@me",LL_API_BaseUrl]];
    MutableRequest *request = [[MutableRequest alloc] initWithURL:url andParameters:parameters andType:@"POST"];
    
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    [self settingUpData:data andResponse:response];
    
    return _jsonDict;
}

+ (void)logoutWithToken:(NSString*)token
{
    ProfileRequest *profileRequest = [[ProfileRequest alloc] init];
    [profileRequest logoutWithToken:token];
    profileRequest = nil;
}

- (void)logoutWithToken:(NSString*)token
{
    if (_connection == nil) {
		_data = [NSMutableData new];
        
        /*
         Sets the body of the requests
         Countains token
         */
        NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
        [parameters setValue:token forKey:@"authToken"];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@logout",LL_API_BaseUrl]];
        MutableRequest *request = [[MutableRequest alloc] initWithURL:url andParameters:parameters andType:@"POST"];
        
        _connection = [NSURLConnection connectionWithRequest:request delegate:self];
    }
}

- (void)settingUpData:(NSData*)data andResponse:(NSURLResponse*)response
{
    _statusCode = [(NSHTTPURLResponse*)response statusCode];
    
    if(_statusCode == 200) {
        if(!_jsonDict)
            _jsonDict = [[NSMutableDictionary alloc] init];
        _jsonDict = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        _jsonDict = [_jsonDict objectForKey:@"user"];
    }
    else {
        NSString* response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", response);
    }
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
    
	_connection = nil;
	_data = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection
{	
	_connection = nil;
	_data = nil;
}


@end
