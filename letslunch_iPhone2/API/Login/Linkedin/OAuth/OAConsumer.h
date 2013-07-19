//
//  OAConsumer.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OAConsumer : NSObject {
@protected
	NSString *key;
	NSString *secret;
    NSString *realm;
}
@property(copy, readwrite) NSString *key;
@property(copy, readwrite) NSString *secret;
@property(copy, readwrite) NSString *realm;

- (id)initWithKey:(const NSString *)aKey secret:(const NSString *)aSecret realm:(const NSString *)aRealm;

- (BOOL)isEqualToConsumer:(OAConsumer *)aConsumer;

@end
