//
//  OACall.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OAProblem;
@class OACall;

@protocol OACallDelegate

- (void)call:(OACall *)call failedWithError:(NSError *)error;
- (void)call:(OACall *)call failedWithProblem:(OAProblem *)problem;

@end

@class OAConsumer;
@class OAToken;
@class OADataFetcher;
@class OAMutableURLRequest;
@class OAServiceTicket;

@interface OACall : NSObject {
	NSURL *url;
	NSString *method;
	NSArray *parameters;
	NSDictionary *files;
	NSObject <OACallDelegate> *delegate;
	SEL finishedSelector;
	OADataFetcher *fetcher;
	OAMutableURLRequest *request;
	OAServiceTicket *ticket;
}

@property(readonly) NSURL *url;
@property(readonly) NSString *method;
@property(readonly) NSArray *parameters;
@property(readonly) NSDictionary *files;
@property(nonatomic, retain) OAServiceTicket *ticket;

- (id)init;
- (id)initWithURL:(NSURL *)aURL;
- (id)initWithURL:(NSURL *)aURL method:(NSString *)aMethod;
- (id)initWithURL:(NSURL *)aURL parameters:(NSArray *)theParameters;
- (id)initWithURL:(NSURL *)aURL method:(NSString *)aMethod parameters:(NSArray *)theParameters;
- (id)initWithURL:(NSURL *)aURL parameters:(NSArray *)theParameters files:(NSDictionary*)theFiles;

- (id)initWithURL:(NSURL *)aURL
		   method:(NSString *)aMethod
	   parameters:(NSArray *)theParameters
			files:(NSDictionary*)theFiles;

- (void)perform:(OAConsumer *)consumer
		  token:(OAToken *)token
		  realm:(NSString *)realm
	   delegate:(NSObject <OACallDelegate> *)aDelegate
	  didFinish:(SEL)finished;

@end
