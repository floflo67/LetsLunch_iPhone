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

+ (void)sendMessage:(NSString*)message withToken:(NSString*)token toThread:(NSString*)threadID
{
    [[[MessageRequest alloc] init] sendMessage:message withToken:token toThread:threadID];
}

/*
 Url: http://letslunch.dev.knackforge.com/api/me/message/reply
 Parameters:
    authToken
    id
    message
 */
- (void)sendMessage:(NSString*)message withToken:(NSString*)token toThread:(NSString*)threadID
{
    if (self.connection == nil) {
        NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
        [parameters setValue:token forKey:@"authToken"];
        [parameters setValue:message forKey:@"message"];
        [parameters setValue:threadID forKey:@"id"];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@me/message/reply",LL_API_BaseUrl]];
        MutableRequest *request = [[MutableRequest alloc] initWithURL:url andParameters:parameters andType:@"POST"];
        
        self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    }
}

#pragma mark - connection delegate

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
	[AppDelegate showErrorMessage:error.localizedDescription withErrorStatus:500];
    self.connection = nil;
	self.data = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection
{    
	if (self.statusCode != 200) {
        NSDictionary *dictJson = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:self.data options:0 error:nil]];
        NSDictionary *dictError = [NSDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithDictionary:[dictJson objectForKey:@"error"]]];
		NSString* response = [dictError objectForKey:@"message"];
        NSLog(@"message %@", response);
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
