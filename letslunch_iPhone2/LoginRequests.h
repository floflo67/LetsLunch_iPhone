//
//  LoginRequests.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 10/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginRequests : NSObject

+(void)loginWithUserName:(NSString*)username andPassword:(NSString*)password;
+(void)signUpWithUserName:(NSString*)username andPassword:(NSString*)password andMailAddress:(NSString*)email andCountry:(NSString*)country;

@end
