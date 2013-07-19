//
//  OAHMAC_SHA1SignatureProvider.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "OAHMAC_SHA1SignatureProvider.h"

#include "hmac.h"
#include "Base64Transcoder.h"

@implementation OAHMAC_SHA1SignatureProvider

- (NSString *)name {
    return @"HMAC-SHA1";
}

- (NSString *)signClearText:(NSString *)text withSecret:(NSString *)secret {
    NSData *secretData = [[secret dataUsingEncoding:NSUTF8StringEncoding] retain];
    NSData *clearTextData = [[text dataUsingEncoding:NSUTF8StringEncoding] retain];
    unsigned char result[20];
    hmac_sha1((unsigned char *)[clearTextData bytes], [clearTextData length], (unsigned char *)[secretData bytes], [secretData length], result);
	[secretData release];
	[clearTextData release];
    
    //Base64 Encoding
    
    char base64Result[32];
    size_t theResultLength = 32;
    Base64EncodeData(result, 20, base64Result, &theResultLength);
    NSData *theData = [NSData dataWithBytes:base64Result length:theResultLength];
    
    NSString *base64EncodedResult = [[[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding] autorelease];
    
    return base64EncodedResult;
}

@end
