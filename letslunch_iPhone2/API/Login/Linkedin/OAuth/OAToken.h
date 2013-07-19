//
//  OAToken.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAToken : NSObject {
@protected
	NSString *key;
	NSString *secret;
	NSString *session;
    NSString *verifier;
	NSNumber *duration;
	NSMutableDictionary *attributes;
	NSDate *created;
    NSString *user_id;
    NSString *screen_name;
	BOOL renewable;
	BOOL forRenewal;
}
@property(retain, readwrite) NSString *key;
@property(retain, readwrite) NSString *secret;
@property(retain, readwrite) NSString *session;
@property(retain, readwrite) NSString *verifier;
@property(retain, readwrite) NSNumber *duration;
@property(retain, readwrite) NSMutableDictionary *attributes;
@property(readwrite, getter=isForRenewal) BOOL forRenewal;

@property(retain, readwrite) NSString *user_id;
@property(retain, readwrite) NSString *screen_name;

- (id)initWithKey:(NSString *)aKey secret:(NSString *)aSecret;
- (id)initWithKey:(NSString *)aKey 
           secret:(NSString *)aSecret 
          session:(NSString *)aSession
         verifier:(NSString *)aVerifier
		 duration:(NSNumber *)aDuration 
       attributes:(NSMutableDictionary *)theAttributes 
          created:(NSDate *)creation
          userId:aUserId
      screenName:aScreenName
		renewable:(BOOL)renew;

- (id)initWithHTTPResponseBody:(NSString *)body;

- (id)initWithUserDefaultsUsingServiceProviderName:(NSString *)provider prefix:(NSString *)prefix;
- (int)storeInUserDefaultsWithServiceProviderName:(NSString *)provider prefix:(NSString *)prefix;

- (BOOL)isValid;

- (void)setAttribute:(NSString *)aKey value:(NSString *)aValue;
- (NSString *)attribute:(NSString *)aKey;
- (void)setAttributesWithString:(NSString *)aAttributes;
- (NSString *)attributeString;

- (BOOL)hasExpired;
- (BOOL)isRenewable;
- (void)setDurationWithString:(NSString *)aDuration;
- (void)setVerifierWithUrl:(NSURL *)aURL;
- (BOOL)hasAttributes;
- (NSMutableDictionary *)parameters;

- (BOOL)isEqualToToken:(OAToken *)aToken;

+ (void)removeFromUserDefaultsWithServiceProviderName:(const NSString *)provider prefix:(const NSString *)prefix;

@end
