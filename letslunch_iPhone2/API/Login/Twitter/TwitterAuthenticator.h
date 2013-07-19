//
//  TwitterAuthenticator.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TwitterRequest.h"

@class TwitterConsumer;
@class TwitterToken;
@class TwitterAuthenticator;
@class TwitterRequest;

@protocol TwitterAuthenticatorDelegate
- (void) twitterAuthenticator: (TwitterAuthenticator*) twitterAuthenticator didFailWithError: (NSError*) error;
- (void) twitterAuthenticator: (TwitterAuthenticator*) twitterAuthenticator didSucceedWithToken: (TwitterToken*) token;
@end

@interface TwitterAuthenticator : NSObject <TwitterRequestDelegate> {
  @private
	TwitterConsumer* _consumer;
	NSString* _username;
	NSString* _password;
	id<TwitterAuthenticatorDelegate> _delegate;
  @private
    TwitterRequest* _twitterRequest;
}

@property (nonatomic,retain) TwitterConsumer* consumer;

@property (nonatomic,retain) NSString* username;
@property (nonatomic,retain) NSString* password;

@property (nonatomic,assign) id<TwitterAuthenticatorDelegate> delegate;

- (void) authenticate;
- (void) cancel;

@end