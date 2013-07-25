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

+ (NSDictionary*)getProfileWithToken:(NSString*)token andLight:(BOOL)isLight
{
    ProfileRequest *profileRequest = [[ProfileRequest alloc] init];
    return [profileRequest getProfileWithToken:token andLight:isLight];
}

/*
 URL: http://letslunch.dev.knackforge.com/api/me
 Request Type: POST
 Parameters:
    authToken (Email id)
 */
- (NSDictionary*)getProfileWithToken:(NSString*)token andLight:(BOOL)isLight
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
    
    if(!isLight)
        [self settingUpData:data andResponse:response];
    else
        [self settingUpLightData:data andResponse:response];
    
    return _jsonDict;
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

- (void)settingUpLightData:(NSData*)data andResponse:(NSURLResponse*)response
{
    _statusCode = [(NSHTTPURLResponse*)response statusCode];
    
    if(_statusCode == 200) {
        if(!_jsonDict)
            _jsonDict = [[NSMutableDictionary alloc] init];
        _jsonDict = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        _jsonDict = [_jsonDict objectForKey:@"user"];
        
        NSMutableDictionary *userContact = [[NSMutableDictionary alloc] init];
        NSDictionary *dictProfile = [_jsonDict objectForKey:@"profile"];
        NSDictionary *dictOther = [_jsonDict objectForKey:@"other"];
        
        [userContact setObject:[dictProfile objectForKey:@"uid"] forKey:@"uid"];
        [userContact setObject:[dictProfile objectForKey:@"firstname"] forKey:@"firstname"];
        [userContact setObject:[dictProfile objectForKey:@"lastname"] forKey:@"lastname"];
        [userContact setObject:[dictOther objectForKey:@"headline"] forKey:@"headline"];
        if([dictProfile objectForKey:@"pictureURL"])
            [userContact setObject:[dictProfile objectForKey:@"pictureURL"] forKey:@"pictureURL"];
        
        _jsonDict = userContact;
    }
    else {
        NSString* response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", response);
    }
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
