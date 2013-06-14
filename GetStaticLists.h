//
//  GetStaticLists.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 13/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetStaticLists : NSObject

+(NSMutableArray*)getListActivities;
+(NSMutableArray*)getListFriendsSuggestion;
+(NSMutableArray*)getListMessages;

@end
