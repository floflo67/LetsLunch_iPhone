//
//  MutableRequest.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 11/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "MutableRequest.h"

@implementation MutableRequest

- (id)initWithURL:(NSURL *)URL andParameters:(NSDictionary*)parameters andType:(NSString*)type
{
    self = [super initWithURL:URL];
    if(self) {
        
        NSString* normalizedRequestParameters = [self normalizeParametersInDictionary:parameters];
        NSData* requestData = [normalizedRequestParameters dataUsingEncoding:NSUTF8StringEncoding];
        
        if([type isEqualToString:@"POST"])
            [self createPostRequestWithBody:requestData];
    }
    return self;    
}

- (void)createPostRequestWithBody:(NSData*)body
{
    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:@"admin", @"X_REST_USERNAME", @"admin", @"X_REST_PASSWORD", nil];
    [self setAllHTTPHeaderFields:headers];
    
    [self setHTTPMethod:@"POST"];
    [self setHTTPBody:body];
    [self setValue:[NSString stringWithFormat: @"%d", [body length]] forHTTPHeaderField: @"Content-Length"];
    [self setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-Type"];
}

/*
 Normalize all parameters
 */
- (NSString*)normalizeParametersInDictionary:(NSDictionary*)dict
{
    NSMutableString* normalizedRequestParameters = [NSMutableString string];
    for (NSString* key in [[dict allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)])
    {
        if ([normalizedRequestParameters length] != 0) {
            [normalizedRequestParameters appendString: @"&"];
        }
        
        [normalizedRequestParameters appendString:key];
        [normalizedRequestParameters appendString:@"="];
        if(![key isEqualToString:@"deviceId"])
            [normalizedRequestParameters appendString:[self _formEncodeString:[dict objectForKey:key]]];
        else {
            NSMutableString *deviceID = [NSString stringWithFormat:@"%@",[dict objectForKey:@"deviceId"]];
            deviceID = (NSMutableString*)[deviceID substringFromIndex:29];
            [normalizedRequestParameters appendString:deviceID];
        }
    }
    
    return normalizedRequestParameters;
}

- (NSString*)_formEncodeString:(NSString*)string
{
	NSString* encoded = (NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef) string, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8);
	return [encoded autorelease];
}

@end
