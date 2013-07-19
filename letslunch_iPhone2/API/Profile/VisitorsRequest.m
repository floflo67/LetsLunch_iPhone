//
//  VisitorsRequest.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 19/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "VisitorsRequest.h"
#import "MutableRequest.h"

@implementation VisitorsRequest

/*
 URL: http://letslunch.dev.knackforge.com/api/me
 Request Type: POST
 Parameters:
 authToken (Email id)
 */
- (NSArray*)getVisitorsWithToken:(NSString*)token
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
    
    return _jsonArray;
}

- (void)settingUpData:(NSData*)data andResponse:(NSURLResponse*)response
{
    _statusCode = [(NSHTTPURLResponse*)response statusCode];
    
    NSString* res = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"%@", res);
    
    if(_statusCode == 200) {
        if(!_jsonArray)
            _jsonArray = [[NSMutableArray alloc] init];
        _jsonArray = [NSMutableArray arrayWithArray:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
    }
    else {
        NSString* response = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
        NSLog(@"%@", response);
    }
}

#pragma lifecycle

- (void)dealloc
{
    [_jsonArray release];
    [super dealloc];
}

@end
