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
        NSString* response = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
        NSLog(@"%@", response);
    }
}

#pragma lifecycle

- (void)dealloc
{
    [_jsonDict release];
    [super dealloc];
}

@end
