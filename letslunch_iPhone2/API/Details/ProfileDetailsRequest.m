//
//  ProfileDetailsRequest.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 22/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "ProfileDetailsRequest.h"
#import "MutableRequest.h"


@interface ProfileDetailsRequest()
@property (nonatomic, strong) NSMutableDictionary *jsonDict;
@end

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
    
    [self settingUpData:data andResponse:response];
    
    return self.jsonDict;
}

- (void)settingUpData:(NSData*)data andResponse:(NSURLResponse*)response
{
    NSInteger statusCode = [(NSHTTPURLResponse*)response statusCode];
    
    if(statusCode == 200) {
        self.jsonDict = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        self.jsonDict = [self.jsonDict objectForKey:@"user"];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:self.jsonDict copyItems:NO];
        [dict removeObjectForKey:@"lunch_zone"];
        self.jsonDict = dict;
        
    }
    else {
        NSString* response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", response);
    }
}

#pragma mark - getter and setter

- (NSMutableDictionary*)jsonDict
{
    if(!_jsonDict)
        _jsonDict = [[NSMutableDictionary alloc] init];
    return _jsonDict;
}

@end
