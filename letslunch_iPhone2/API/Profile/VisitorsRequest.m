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

+ (NSMutableArray*)getVisitorsWithToken:(NSString*)token
{
    return [[[VisitorsRequest alloc] init] getVisitorsWithToken:token];
}

/*
 URL: http://letslunch.dev.knackforge.com/api/me/profileVisitors
 Request Type: POST
 Parameters:
    authToken (Email id)
 */
- (NSMutableArray*)getVisitorsWithToken:(NSString*)token
{
    /*
     Sets the body of the requests
     token
     */
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:token forKey:@"authToken"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@me/profileVisitors",LL_API_BaseUrl]];
    MutableRequest *request = [[MutableRequest alloc] initWithURL:url andParameters:parameters andType:@"POST"];
    
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    if(data)
        return [self settingUpData:data andResponse:response];
    else {
        [AppDelegate showNoConnectionMessage];
        return nil;
    }
}

- (NSMutableArray*)settingUpData:(NSData*)data andResponse:(NSURLResponse*)response
{
    NSInteger statusCode = [(NSHTTPURLResponse*)response statusCode];
    
    if(statusCode == 200) {
        
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        dict = [dict objectForKey:@"profileVisitors"];
        data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        return jsonArray;
    }
    else {
        NSString* response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"visitor %@", response);
        return nil;
    }
}

@end
