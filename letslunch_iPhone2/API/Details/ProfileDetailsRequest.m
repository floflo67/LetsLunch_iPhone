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

- (NSDictionary*)getProfileWithToken:(NSString*)token andID:(NSString*)userID
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:token forKey:@"authToken"];
    [parameters setValue:userID forKey:@"uid"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@people",LL_API_BaseUrl]];
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

- (NSMutableDictionary*)settingUpData:(NSData*)data andResponse:(NSURLResponse*)response
{
    NSInteger statusCode = [(NSHTTPURLResponse*)response statusCode];
    
    if(statusCode == 200) {
        NSMutableDictionary *jsonDict = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        jsonDict = [jsonDict objectForKey:@"user"];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:jsonDict copyItems:NO];
        [dict removeObjectForKey:@"lunch_zone"];
        jsonDict = dict;
        return jsonDict;
    }
    else {
        NSString* response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [AppDelegate showNoConnectionMessage];
        NSLog(@"profiledetail %@", response);
        return nil;
    }
}

@end
