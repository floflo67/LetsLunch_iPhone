//
//  OADataFetcher.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "OADataFetcher.h"


@implementation OADataFetcher

- (id)init {
	[super init];
	responseData = [[NSMutableData alloc] init];
	return self;
}

- (void)dealloc {
	[connection release];
	[response release];
	[responseData release];
	[request release];
	[super dealloc];
}

/* Protocol for async URL loading */
- (void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)aResponse {
	[response release];
	response = [aResponse retain];
	[responseData setLength:0];
}
	
- (void)connection:(NSURLConnection *)aConnection didFailWithError:(NSError *)error {
	OAServiceTicket *ticket = [[OAServiceTicket alloc] initWithRequest:request
															  response:response
																  data:responseData
															didSucceed:NO];

	[delegate performSelector:didFailSelector withObject:ticket withObject:error];
	[ticket release];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	OAServiceTicket *ticket = [[OAServiceTicket alloc] initWithRequest:request
															  response:response
																  data:responseData
															didSucceed:[(NSHTTPURLResponse *)response statusCode] < 400];

	[delegate performSelector:didFinishSelector withObject:ticket withObject:responseData];
	[ticket release];
}

- (void)fetchDataWithRequest:(OAMutableURLRequest *)aRequest delegate:(id)aDelegate didFinishSelector:(SEL)finishSelector didFailSelector:(SEL)failSelector 
{
	[request release];
	request = [aRequest retain];
    delegate = aDelegate;
    didFinishSelector = finishSelector;
    didFailSelector = failSelector;
    
    [request prepare];
    
	connection = [[NSURLConnection alloc] initWithRequest:aRequest delegate:self];
}

@end
