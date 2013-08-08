//
//  SocialConnectionRequest.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 02/08/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SocialConnectionRequest : NSObject

+(NSArray*)getSocialConnectionWithToken:(NSString*)token;

@end
