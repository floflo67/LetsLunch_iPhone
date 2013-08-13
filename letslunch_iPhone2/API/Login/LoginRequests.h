//
//  LoginRequests.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 10/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

@interface LoginRequests : NSObject
    
-(BOOL)loginWithUserName:(NSString*)username andPassword:(NSString*)password;
-(BOOL)signUpWithUserName:(NSString*)username andPassword:(NSString*)password andMailAddress:(NSString*)email andCountry:(NSString*)country;

@end
