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
@property (nonatomic) NSInteger statusCode;
@end

@implementation SocialConnectionRequest

+ (void)getSocialConnectionWithToken:(NSString *)token
{
    return [[[SocialConnectionRequest alloc] init] getSocialConnectionWithToken:token];
}

/*
 URL: http://letslunch.dev.knackforge.com/api/me/socialconnect
 Request Type: POST
 Parameters:
    authToken (token)
 */

- (void)getSocialConnectionWithToken:(NSString *)token
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:token forKey:@"authToken"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@me/socialconnect",LL_API_BaseUrl]];
    MutableRequest *request = [[MutableRequest alloc] initWithURL:url andParameters:parameters andType:@"POST"];
    
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    [self settingUpData:data andResponse:response];
}

- (void)settingUpData:(NSData*)data andResponse:(NSURLResponse*)response
{
    self.statusCode = [(NSHTTPURLResponse*)response statusCode];
    
    if(self.statusCode == 200) {
        NSMutableDictionary *jsonDict = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        NSLog(@"social: %@", jsonDict);
        //self.jsonDict = [self.jsonDict objectForKey:@"user"];
    }
    else {
        NSString* response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if(response.length < 100)
            NSLog(@"%@", response);
    }
}

@end
