//
//  OATokenManager.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OACall.h"

@class OATokenManager;

@protocol OATokenManagerDelegate

- (BOOL)tokenManager:(OATokenManager *)manager failedCall:(OACall *)call withError:(NSError *)error;
- (BOOL)tokenManager:(OATokenManager *)manager failedCall:(OACall *)call withProblem:(OAProblem *)problem;

@optional

- (BOOL)tokenManagerNeedsToken:(OATokenManager *)manager;

@end

@class OAConsumer;
@class OAToken;

@interface OATokenManager : NSObject<OACallDelegate> {
	OAConsumer *consumer;
	OAToken *acToken;
	OAToken *reqToken;
	OAToken *initialToken;
	NSString *authorizedTokenKey;
	NSString *oauthBase;
	NSString *realm;
	NSString *callback;
	NSObject <OATokenManagerDelegate> *delegate;
	NSMutableArray *calls;
	NSMutableArray *selectors;
	NSMutableDictionary *delegates;
	BOOL isDispatching;
}


- (id)init;

- (id)initWithConsumer:(OAConsumer *)aConsumer token:(OAToken *)aToken oauthBase:(const NSString *)base
				 realm:(const NSString *)aRealm callback:(const NSString *)aCallback
			  delegate:(NSObject <OATokenManagerDelegate> *)aDelegate;

- (void)authorizedToken:(const NSString *)key;

- (void)fetchData:(NSString *)aURL finished:(SEL)didFinish;

- (void)fetchData:(NSString *)aURL method:(NSString *)aMethod parameters:(NSArray *)theParameters
		 finished:(SEL)didFinish;

- (void)fetchData:(NSString *)aURL method:(NSString *)aMethod parameters:(NSArray *)theParameters
			files:(NSDictionary *)theFiles finished:(SEL)didFinish;

- (void)fetchData:(NSString *)aURL method:(NSString *)aMethod parameters:(NSArray *)theParameters
			files:(NSDictionary *)theFiles finished:(SEL)didFinish delegate:(NSObject*)aDelegate;

- (void)call:(OACall *)call failedWithError:(NSError *)error;
- (void)call:(OACall *)call failedWithProblem:(OAProblem *)problem;

@end
