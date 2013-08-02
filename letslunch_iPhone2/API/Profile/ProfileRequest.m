//
//  ProfileRequest.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 11/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "ProfileRequest.h"
#import "MutableRequest.h"

@interface ProfileRequest()
@property (nonatomic) NSInteger statusCode;
@property (nonatomic, strong) NSMutableDictionary *jsonDict;
@property (nonatomic, strong) NSURLConnection* connection;
@property (nonatomic, strong) NSMutableData* data;
@end

@implementation ProfileRequest

+ (NSDictionary*)getProfileWithToken:(NSString*)token andLight:(BOOL)isLight
{
    return [[[ProfileRequest alloc] init] getProfileWithToken:token andLight:isLight];
}

/*
 URL: http://letslunch.dev.knackforge.com/api/me
 Request Type: POST
 Parameters:
    authToken (Email id)
 */
- (NSDictionary*)getProfileWithToken:(NSString*)token andLight:(BOOL)isLight
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
    
    if(!isLight)
        [self settingUpData:data andResponse:response];
    else
        [self settingUpLightData:data andResponse:response];
    
    return self.jsonDict;
}

- (void)settingUpData:(NSData*)data andResponse:(NSURLResponse*)response
{
    self.statusCode = [(NSHTTPURLResponse*)response statusCode];
    
    if(self.statusCode == 200) {
        self.jsonDict = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        self.jsonDict = [self.jsonDict objectForKey:@"user"];
    }
    else {
        NSString* response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", response);
    }
}

- (void)settingUpLightData:(NSData*)data andResponse:(NSURLResponse*)response
{
    self.statusCode = [(NSHTTPURLResponse*)response statusCode];
    
    if(self.statusCode == 200) {
        self.jsonDict = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        self.jsonDict = [self.jsonDict objectForKey:@"user"];
        
        NSMutableDictionary *userContact = [[NSMutableDictionary alloc] init];
        NSDictionary *dictProfile = [self.jsonDict objectForKey:@"profile"];
        NSDictionary *dictOther = [self.jsonDict objectForKey:@"other"];
        
        [userContact setObject:[dictProfile objectForKey:@"uid"] forKey:@"uid"];
        [userContact setObject:[dictProfile objectForKey:@"firstname"] forKey:@"firstname"];
        [userContact setObject:[dictProfile objectForKey:@"lastname"] forKey:@"lastname"];
        [userContact setObject:[dictOther objectForKey:@"headline"] forKey:@"headline"];
        if([dictProfile objectForKey:@"pictureUrl"])
            [userContact setObject:[dictProfile objectForKey:@"pictureUrl"] forKey:@"pictureURL"];
        
        self.jsonDict = userContact;
    }
    else {
        NSString* response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", response);
    }
}

+ (void)logoutWithToken:(NSString*)token
{
    [[[ProfileRequest alloc] init] logoutWithToken:token];
}

- (void)logoutWithToken:(NSString*)token
{
    if (self.connection == nil) {
        
        /*
         Sets the body of the requests
         Countains token
         */
        NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
        [parameters setValue:token forKey:@"authToken"];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@logout",LL_API_BaseUrl]];
        MutableRequest *request = [[MutableRequest alloc] initWithURL:url andParameters:parameters andType:@"POST"];
        
        self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    }
}

#pragma connection delegate

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
	[self.data appendData:data];
}

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSHTTPURLResponse*)response
{
	self.statusCode = [response statusCode];
}

- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    NSLog(@"error");
    
	self.connection = nil;
	self.data = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection
{	
	self.connection = nil;
	self.data = nil;
}

#pragma mark - getter and setter

- (NSMutableData*)data
{
    if(!_data)
        _data = [NSMutableData new];
    return _data;
}

- (NSMutableDictionary*)jsonDict
{
    if(!_jsonDict)
        _jsonDict = [[NSMutableDictionary alloc] init];
    return _jsonDict;
}

@end
