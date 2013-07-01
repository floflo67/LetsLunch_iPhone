//
//  OARequestParameter.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+URLEncoding.h"


@interface OARequestParameter : NSObject {
@protected
    NSString *name;
    NSString *value;
}
@property(copy, readwrite) NSString *name;
@property(copy, readwrite) NSString *value;

- (id)initWithName:(NSString *)aName value:(NSString *)aValue;
- (NSString *)URLEncodedName;
- (NSString *)URLEncodedValue;
- (NSString *)URLEncodedNameValuePair;

- (BOOL)isEqualToRequestParameter:(OARequestParameter *)parameter;

+ (id)requestParameter:(NSString *)aName value:(NSString *)aValue;

@end
