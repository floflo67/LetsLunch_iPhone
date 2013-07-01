//
//  TwitterToken.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "TwitterToken.h"

@implementation TwitterToken

#pragma mark -

@synthesize
	token = _token,
	secret = _secret;
	
#pragma mark -

- (id) initWithToken: (NSString*) token secret: (NSString*) secret
{
	if ((self = [super init]) != nil) {
		_token = [token retain];
		_secret = [secret retain];
	}
	return self;
}

- (void) dealloc
{
	[_token release];
	[_secret release];
	[super dealloc];
}

#pragma mark -

- (id) initWithCoder: (NSCoder*) coder
{
	if ((self = [super init]) != nil) {
		_token = [[coder decodeObjectForKey: @"token"] retain];
		_secret = [[coder decodeObjectForKey: @"secret"] retain];
	}
	return self;
}

- (void) encodeWithCoder: (NSCoder*) coder
{
    [coder encodeObject: _token forKey: @"token"];
    [coder encodeObject: _secret forKey: @"secret"];
}

#pragma mark -

- (NSString*) description
{
	return [NSString stringWithFormat: @"<TwitterToken@0x%@ token=%@ secret=%@>", self, _token, _secret];
}

@end