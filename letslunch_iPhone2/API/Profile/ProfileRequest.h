//
//  ProfileRequest.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 11/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileRequest : NSObject

+(NSDictionary*)getProfileWithToken:(NSString*)token andLight:(BOOL)isLight;
-(NSDictionary*)getProfileWithToken:(NSString*)token andLight:(BOOL)isLight;

+(void)logoutWithToken:(NSString*)token;

@end
