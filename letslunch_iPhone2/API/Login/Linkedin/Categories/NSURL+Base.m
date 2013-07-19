//
//  NSURL+Base.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "NSURL+Base.h"


@implementation NSURL (OABaseAdditions)

- (NSString *)URLStringWithoutQuery {
    NSArray *parts = [[self absoluteString] componentsSeparatedByString:@"?"];
    return [parts objectAtIndex:0];
}

@end
