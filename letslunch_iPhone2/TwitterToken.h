//
//  TwitterToken.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwitterToken : NSObject <NSCoding> {
  @private
	NSString* _token;
	NSString* _secret;
}

@property (nonatomic,retain) NSString* token;
@property (nonatomic,retain) NSString* secret;

- (id) initWithToken: (NSString*) token secret: (NSString*) secret;

@end