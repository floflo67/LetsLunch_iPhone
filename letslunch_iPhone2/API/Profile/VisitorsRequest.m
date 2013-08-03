//
//  VisitorsRequest.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 19/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "VisitorsRequest.h"
#import "MutableRequest.h"

@interface VisitorsRequest()
@property (nonatomic, strong) NSMutableArray *jsonArray;
@end

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
    
    [self settingUpData:data andResponse:response];
    
    return self.jsonArray;
}

- (void)settingUpData:(NSData*)data andResponse:(NSURLResponse*)response
{
    NSInteger statusCode = [(NSHTTPURLResponse*)response statusCode];
    
    if(statusCode == 200) {
        
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        dict = [dict objectForKey:@"profileVisitors"];
        data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        self.jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    }
    else {
        NSString* response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"visitor %@", response);
    }
}

#pragma mark - getter and setter

- (NSMutableArray*)jsonArray
{
    if(!_jsonArray)
        _jsonArray = [[NSMutableArray alloc] init];
    return _jsonArray;
}

@end
