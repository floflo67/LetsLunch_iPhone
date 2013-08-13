//
//  ProfileDetailsRequest.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 22/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

@interface ProfileDetailsRequest : NSObject

-(NSDictionary*)getProfileWithToken:(NSString*)token andID:(NSString*)userID;

@end
