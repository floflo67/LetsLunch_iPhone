//
//  GetStaticLists.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 13/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Activity.h"

@interface GetStaticLists : NSObject

+(NSMutableArray*)getListActivities;
+(NSMutableArray*)getListFriendsSuggestion;
+(NSMutableArray*)getListVisitors;
+(NSMutableArray*)getListMessagesForContactID:(NSString*)contactID;
+(Activity*)getOwnerActivityWithToken:(NSString*)token;
+(NSMutableArray*)getListContacts;

@end
