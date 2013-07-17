//
//  LunchesRequest.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 17/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "LunchesRequest.h"
#import "MutableRequest.h"

@implementation LunchesRequest

+ (NSDictionary *)getLunchWithToken:(NSString *)token
{
    LunchesRequest *lunchRequest = [[[LunchesRequest alloc] init] autorelease];
    return [lunchRequest getLunchWithToken:token];
}

- (NSDictionary *)getLunchWithToken:(NSString *)token
{
    NSLog(@"%@", token);
    /*
     Sets the body of the requests
     Countains username, password and device ID
     */
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:token forKey:@"authToken"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@me/lunch/upcoming",LL_API_BaseUrl]];
    MutableRequest *request = [[MutableRequest alloc] initWithURL:url andParameters:parameters andType:@"POST"];
    
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    [self settingUpData:data andResponse:response];
    
    return _jsonDict;
}

+ (NSDictionary *)suppressLunchWithToken:(NSString *)token andDate:(NSString *)date
{
    LunchesRequest *lunchRequest = [[[LunchesRequest alloc] init] autorelease];
    return [lunchRequest suppressLunchWithToken:token andDate:date];
}

- (NSDictionary *)suppressLunchWithToken:(NSString *)token andDate:(NSString *)date
{
    /*
     Sets the body of the requests
     Countains username, password and device ID
     */
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:token forKey:@"authToken"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@me",LL_API_BaseUrl]];
    MutableRequest *request = [[MutableRequest alloc] initWithURL:url andParameters:parameters andType:@"POST"];
    //_connection = [[NSURLConnection connectionWithRequest:request delegate:self] retain];
    
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
        
        NSMutableArray *arr = [NSMutableArray arrayWithArray:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        if(arr.count > 0) {
            _jsonDict = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
            _jsonDict = [_jsonDict objectForKey:@"user"];
        }
        else {
            _jsonDict = nil;
        }
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
