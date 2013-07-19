//
//  OAServiceTicket.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "OAServiceTicket.h"


@implementation OAServiceTicket
@synthesize request, response, data, didSucceed;

- (id)initWithRequest:(OAMutableURLRequest *)aRequest response:(NSURLResponse *)aResponse data:(NSData *)aData didSucceed:(BOOL)success {
    [super init];
    request = aRequest;
    response = aResponse;
	data = aData;
    didSucceed = success;
    return self;
}

- (NSString *)body
{
	if (!data) {
		return nil;
	}
	
	return [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
}

@end
