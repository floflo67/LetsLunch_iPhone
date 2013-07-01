//
//  OAMutableURLRequest.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAConsumer.h"
#import "OAToken.h"
#import "OAHMAC_SHA1SignatureProvider.h"
#import "OASignatureProviding.h"
#import "NSMutableURLRequest+Parameters.h"
#import "NSURL+Base.h"


@interface OAMutableURLRequest : NSMutableURLRequest {
@protected
    OAConsumer *consumer;
    OAToken *token;
    NSString *signature;
    NSString *callback;
    id<OASignatureProviding> signatureProvider;
    NSString *nonce;
    NSString *timestamp;
}
@property(readonly) NSString *signature;
@property(readonly) NSString *nonce;


- (id)initWithURL:(NSURL *)aUrl
		 consumer:(OAConsumer *)aConsumer
			token:(OAToken *)aToken
         callback:(NSString *)aCallback
signatureProvider:(id<OASignatureProviding, NSObject>)aProvider;

 
- (id)initWithURL:(NSURL *)aUrl
		 consumer:(OAConsumer *)aConsumer
			token:(OAToken *)aToken
signatureProvider:(id<OASignatureProviding, NSObject>)aProvider
            nonce:(NSString *)aNonce
        timestamp:(NSString *)aTimestamp;

- (void)prepare;

@end
