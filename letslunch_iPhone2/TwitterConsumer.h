//
//  TwitterConsumer.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwitterConsumer : NSObject {
  @private
	NSString* _key;
	NSString* _secret;
}

@property (nonatomic,readonly) NSString* key;
@property (nonatomic,readonly) NSString* secret;

- (id) initWithKey: (NSString*) key secret: (NSString*) secret;

@end
