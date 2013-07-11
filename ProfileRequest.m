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

- (NSDictionary*)getProfileWithToken:(NSString*)token
{
    if (_connection == nil) {
		_data = [NSMutableData new];
        
        /*
         Sets the body of the requests
         Countains username, password and device ID
         */
        NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
        [parameters setValue:token forKey:@"authToken"];        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@profile",LL_API_BaseUrl]];
        MutableRequest *request = [[MutableRequest alloc] initWithURL:url andParameters:parameters andType:@"POST"];
        _connection = [[NSURLConnection connectionWithRequest:request delegate:self] retain];
    }
    
    return _jsonDict;
}


#pragma custom function

- (void)cancel
{
	if (_connection != nil) {
		[_connection cancel];
		[_connection release];
		_connection = nil;
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
    
	[_connection release];
	_connection = nil;
	
	[_data release];
	_data = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection
{
	if (_statusCode != 200) {
		NSString* response = [[[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding] autorelease];
        NSLog(@"%@", response);
	}
    else {
        if(!_jsonDict)
            _jsonDict = [[NSMutableDictionary alloc] init];
        _jsonDict = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:_data options:0 error:nil]];
        _jsonDict = [_jsonDict objectForKey:@"user"];
        _jsonDict = [_jsonDict objectForKey:@"info"];	}
	
	[_connection release];
	_connection = nil;
	
	[_data release];
	_data = nil;
}

#pragma lifecycle

- (void)dealloc
{
    [_jsonDict release];
    [_connection release];
    [_data release];
    [super dealloc];
}

@end
