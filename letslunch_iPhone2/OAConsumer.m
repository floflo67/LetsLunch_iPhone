//
//  OAConsumer.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "OAConsumer.h"


@implementation OAConsumer
@synthesize key, secret, realm;

#pragma mark init

- (id)initWithKey:(const NSString *)aKey secret:(const NSString *)aSecret realm:(const NSString *)aRealm {
	[super init];
	self.key = [aKey retain];
	self.secret = [aSecret retain];
    self.realm = [aRealm retain];
	return self;
}

- (BOOL)isEqual:(id)object {
	if ([object isKindOfClass:[self class]]) {
		return [self isEqualToConsumer:(OAConsumer*)object];
	}
	return NO;
}

- (BOOL)isEqualToConsumer:(OAConsumer *)aConsumer {
	return ([self.key isEqualToString:aConsumer.key] &&
			[self.secret isEqualToString:aConsumer.secret] &&
            [self.realm isEqualToString:aConsumer.realm]);
}

@end
