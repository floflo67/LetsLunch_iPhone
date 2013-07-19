//
//  NSMutableURLRequest+Parameters.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OARequestParameter.h"
#import "NSURL+Base.h"


@interface NSMutableURLRequest (OAParameterAdditions)

@property(nonatomic, retain) NSArray *parameters;

- (void)setHTTPBodyWithString:(NSString *)body;
- (void)attachFileWithName:(NSString *)name filename:(NSString*)filename contentType:(NSString *)contentType data:(NSData*)data;

@end
