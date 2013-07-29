//
//  MessageRequest.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 29/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "MessageRequest.h"
#import "MutableRequest.h"

@implementation MessageRequest

+ (void)sendMessage:(NSString*)message withToken:(NSString*)token toUser:(NSString*)userID
{
    MessageRequest *messageRequest = [[MessageRequest alloc] init];
    [messageRequest sendMessage:message withToken:token toUser:userID];
    messageRequest = nil;
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
    if (_connection == nil) {
		_data = [NSMutableData new];
        NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
        [parameters setValue:token forKey:@"authToken"];
        [parameters setValue:message forKey:@"message"];
        [parameters setValue:userID forKey:@"uid"];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@me/message/new",LL_API_BaseUrl]];
        MutableRequest *request = [[MutableRequest alloc] initWithURL:url andParameters:parameters andType:@"POST"];
        
        _connection = [NSURLConnection connectionWithRequest:request delegate:self];
    }
}

#pragma connection delegate

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
	[_data appendData:data];
}

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSHTTPURLResponse*)response
{
	_statusCode = [response statusCode];
}

- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
	_connection = nil;
	_data = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    NSString* response = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", response);
    
	if (_statusCode != 200) {
        NSDictionary *dictJson = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:_data options:0 error:nil]];
        NSDictionary *dictError = [NSDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithDictionary:[dictJson objectForKey:@"error"]]];
		NSString* response = [dictError objectForKey:@"message"];
        NSLog(@"%@", response);
	}
	
	_connection = nil;
	_data = nil;
}

@end
