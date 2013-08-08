//
//  SocialConnectionRequest.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 02/08/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "SocialConnectionRequest.h"
#import "MutableRequest.h"

@interface SocialConnectionRequest()

@end

@implementation SocialConnectionRequest

+ (NSArray*)getSocialConnectionWithToken:(NSString*)token
{
    return [[[SocialConnectionRequest alloc] init] getSocialConnectionWithToken:token];
}

/*
 URL: http://letslunch.dev.knackforge.com/api/me/socialconnect
 Request Type: POST
 Parameters:
    authToken (token)
 */

- (NSArray*)getSocialConnectionWithToken:(NSString*)token
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:token forKey:@"authToken"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@me/socialconnect",LL_API_BaseUrl]];
    MutableRequest *request = [[MutableRequest alloc] initWithURL:url andParameters:parameters andType:@"POST"];
    
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    return [self settingUpData:data andResponse:response];
}

- (NSArray*)settingUpData:(NSData*)data andResponse:(NSURLResponse*)response
{
    NSInteger statusCode = [(NSHTTPURLResponse*)response statusCode];
    NSArray *jsonArray = [NSArray arrayWithArray:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
    if([jsonArray count] == 0)
        statusCode = 201;
    
    if(statusCode == 200) {
        NSLog(@"social: %@", jsonArray);
        return jsonArray;
        //self.jsonDict = [self.jsonDict objectForKey:@"user"];
    }
    else if (statusCode == 201)
        return nil;
    else {
        NSString* response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"socialconnection err: %@", response);
        return nil;
    }
}

@end
