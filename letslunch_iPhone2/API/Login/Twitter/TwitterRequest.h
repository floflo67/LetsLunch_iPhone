//
//  TwitterRequest.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TwitterToken;
@class TwitterRequest;
@class TwitterConsumer;

@protocol TwitterRequestDelegate
- (void) twitterRequest: (TwitterRequest*) request didFailWithError: (NSError*) error;
- (void) twitterRequest:(TwitterRequest *)request didFinishLoadingData: (NSData*) data;
@end

@interface TwitterRequest : NSObject {
  @private
	TwitterConsumer* _twitterConsumer;
	NSDictionary* _parameters;
	TwitterToken* _token;
	NSURL* _url;
	NSURL* _realm;
	NSString* _method;
	id<TwitterRequestDelegate> _delegate;
  @private
	NSURLConnection* _connection;
	NSMutableData* _data;
	NSInteger _statusCode;
}

@property (nonatomic,retain) TwitterConsumer* twitterConsumer;
@property (nonatomic,retain) NSDictionary* parameters;
@property (nonatomic,retain) TwitterToken* token;
@property (nonatomic,retain) NSString* method;
@property (nonatomic,retain) NSURL* url;
@property (nonatomic,retain) NSURL* realm;
@property (nonatomic,assign) id<TwitterRequestDelegate> delegate;

- (void) execute;
- (void) cancel;

@end