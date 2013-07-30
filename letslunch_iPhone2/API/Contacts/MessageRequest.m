//
//  MessageRequest.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 29/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "MessageRequest.h"
#import "MutableRequest.h"

@interface MessageRequest()
@property (nonatomic, strong) NSURLConnection* connection;
@property (nonatomic, strong) NSMutableData* data;
@property (nonatomic) NSInteger statusCode;
@end

@implementation MessageRequest

+ (void)sendMessage:(NSString*)message withToken:(NSString*)token toUser:(NSString*)userID
{
    [[[MessageRequest alloc] init] sendMessage:message withToken:token toUser:userID];
}

/*
 Url: http://letslunch.dev.knackforge.com/api/me/message/new
 Parameters:
    authToken
    uid
    message
 */
- (void)sendMessage:(NSString*)message withToken:(NSString*)token toUser:(NSString*)userID
{
    if (self.connection == nil) {
        NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
        [parameters setValue:token forKey:@"authToken"];
        [parameters setValue:message forKey:@"message"];
        [parameters setValue:userID forKey:@"uid"];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@me/message/new",LL_API_BaseUrl]];
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
	self.connection = nil;
	self.data = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    NSString* response = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", response);
    
	if (self.statusCode != 200) {
        NSDictionary *dictJson = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:self.data options:0 error:nil]];
        NSDictionary *dictError = [NSDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithDictionary:[dictJson objectForKey:@"error"]]];
		NSString* response = [dictError objectForKey:@"message"];
        NSLog(@"%@", response);
	}
	
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

@end
