//
//  TwitterConsumer.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "TwitterConsumer.h"

@implementation TwitterConsumer

@synthesize
	key = _key,
	secret = _secret;

- (id) initWithKey: (NSString*) key secret: (NSString*) secret
{
	if ((self = [super init]) != nil) {
		_key = [key retain];
		_secret = [secret retain];
	}
	return self;
}

- (void) dealloc
{
	[_key release];
	[_secret release];
	[super dealloc];
}

@end