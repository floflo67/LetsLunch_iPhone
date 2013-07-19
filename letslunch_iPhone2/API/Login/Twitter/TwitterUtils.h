//
//  TwitterUtils.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwitterUtils : NSObject {

}

+ (NSString*) encodeData: (NSData*) data;
+ (NSData*) generateSignatureOverString: (NSString*) string withSecret: (NSData*) secret;

@end
