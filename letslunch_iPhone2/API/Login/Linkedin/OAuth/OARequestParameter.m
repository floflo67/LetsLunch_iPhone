//
//  OARequestParameter.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "OARequestParameter.h"


@implementation OARequestParameter
@synthesize name, value;

- (id)initWithName:(NSString *)aName value:(NSString *)aValue {
    [super init];
    self.name = aName;
    self.value = aValue;
    return self;
}

- (NSString *)URLEncodedName {
	return self.name;
//    return [self.name encodedURLParameterString];
}

- (NSString *)URLEncodedValue {
    return [self.value encodedURLParameterString];
}

- (NSString *)URLEncodedNameValuePair {
    return [NSString stringWithFormat:@"%@=%@", [self URLEncodedName], [self URLEncodedValue]];
}

- (BOOL)isEqual:(id)object {
	if ([object isKindOfClass:[self class]]) {
		return [self isEqualToRequestParameter:(OARequestParameter *)object];
	}
	
	return NO;
}

- (BOOL)isEqualToRequestParameter:(OARequestParameter *)parameter {
	return ([self.name isEqualToString:parameter.name] &&
			[self.value isEqualToString:parameter.value]);
}


+ (id)requestParameter:(NSString *)aName value:(NSString *)aValue
{
	return [[[self alloc] initWithName:aName value:aValue] autorelease];
}

@end
