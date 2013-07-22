//
//  ProfileDetailsRequest.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 22/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "ProfileDetailsRequest.h"
#import "MutableRequest.h"

@implementation ProfileDetailsRequest

+ (NSDictionary*)getProfileWithToken:(NSString*)token andID:(NSString*)userID
{
    ProfileDetailsRequest *request = [[ProfileDetailsRequest alloc] init];
    NSDictionary *dict = [request getProfileWithToken:token andID:userID];
    [request release];
    return dict;
}

- (NSDictionary*)getProfileWithToken:(NSString*)token andID:(NSString*)userID
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:token forKey:@"authToken"];
    [parameters setValue:userID forKey:@"uid"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@people",LL_API_BaseUrl]];
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
