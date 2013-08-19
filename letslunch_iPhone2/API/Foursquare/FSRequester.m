//
//  FSRequester.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 20/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "FSRequester.h"
#import "FSTargetCallback.h"

@implementation FSRequester
@synthesize asyncConnDict;
@synthesize requestHistory;

#pragma mark - clang diagnostic ignored "-Warc-performSelector-leaks"
    
- (id)init
{
    self = [super init];
    if (self) {
        needToShowErrorAlert = YES;
    }
    self.asyncConnDict = [NSMutableDictionary dictionaryWithCapacity:1];
    return self;
}

- (void)changeStateErrorAlert
{
    needToShowErrorAlert = YES;
}

- (void)handleConnectionError:(NSError*)error
{
	if(!error)
		return;
}

- (void) makeAsyncRequest:(NSURL*)url target:(FSTargetCallback*)target
{
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:TIMEOUT_INTERVAL];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self] ;
	if (connection) {
		[target setData:[NSMutableData data]];
        [self connectTarget:target andConnection:connection];
	}
    else {
		NSMutableDictionary *dict  = [NSMutableDictionary dictionaryWithObject:@"async_conn_creation_failed" forKey:NSLocalizedDescriptionKey];
		NSError *error = [NSError errorWithDomain:@"com.com" code:0 userInfo:dict];
		
		[self handleConnectionError: error];
	}
}

- (void)connectTarget:(FSTargetCallback*)target andConnection:(NSURLConnection*)connection
{
   [asyncConnDict setValue:target forKey:[NSString stringWithFormat: @"%d", [connection hash]]];
}

- (void)disconnettargetWithConnection:(NSURLConnection*)connection
{
    [asyncConnDict removeObjectForKey: [NSString stringWithFormat: @"%d", [connection hash]]];
}

- (FSTargetCallback*)targetForConnection:(NSURLConnection*)connection
{
    return asyncConnDict[[NSString stringWithFormat: @"%d", [connection hash]]];
}

- (void) makeAsyncRequestWithRequest:(NSURLRequest*)urlRequest target:(FSTargetCallback*)target
{
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self] ;
	
	if (connection) {
		// Create the NSMutableData that will hold the received data
		[target setData:[NSMutableData data]];
        [self connectTarget:target andConnection:connection];
	}
    else {
		NSMutableDictionary *dict  = [NSMutableDictionary dictionaryWithObject:@"async_conn_creation_failed" forKey:NSLocalizedDescriptionKey];
		NSError *error = [NSError errorWithDomain:@"com.com" code:0 userInfo: dict];
		
		[self handleConnectionError: error];
	}
}

#pragma mark - NSURLConnection

// fot untrusted stage
//from http://stackoverflow.com/questions/933331/how-to-use-nsurlconnection-to-connect-with-ssl-for-an-untrusted-cert
- (BOOL)connection:(NSURLConnection*)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace*)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection*)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge*)challenge
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection*)aConnection didReceiveResponse:(NSURLResponse*)response
{
	FSTargetCallback *target = [self targetForConnection:aConnection];
	NSMutableData *receivedData = [target receivedData];
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection*)aConnection didReceiveData:(NSData*)data
{
	FSTargetCallback *target = [self targetForConnection:aConnection];
	NSMutableData *receivedData = [target receivedData];
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)aConnection
{
	FSTargetCallback *target = [self targetForConnection:aConnection];
	NSMutableData *receivedData = [target receivedData];
    
	id result = nil;
    result = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:nil];
	if (target.resultCallback) {
        [self performSelector:@selector(callback:target:) withObject:result withObject:target];
    }
    
    // release the connection, and the data object
    [self disconnettargetWithConnection:aConnection];
}

- (void)connection:(NSURLConnection*)aConnection didFailWithError:(NSError*)error
{
	[self disconnettargetWithConnection:aConnection];
}

- (NSCachedURLResponse*)connection:(NSURLConnection*)connection willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
	return nil;
}

@end
