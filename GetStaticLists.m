//
//  GetStaticLists.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 13/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "GetStaticLists.h"

@implementation GetStaticLists

+ (NSArray*) getListActivities
{
    NSMutableArray* listActivities = [[[NSMutableArray alloc] init] autorelease];
    
    [listActivities addObject:@"Activity1"];
    [listActivities addObject:@"Activity2"];
    [listActivities addObject:@"Activity3"];
    
    
    return listActivities;
}


+ (NSMutableArray*) getListFriendsSuggestion
{
    NSMutableArray* listFriendsSuggestion = [[[NSMutableArray alloc] init] autorelease];
    
    [listFriendsSuggestion addObject:@"Suggestion1"];
    [listFriendsSuggestion addObject:@"Suggestion2"];
    [listFriendsSuggestion addObject:@"Suggestion3"];
    
    
    return listFriendsSuggestion;
}

+ (NSMutableArray*) getListMessages
{
    NSMutableArray* listMessages = [[[NSMutableArray alloc] init] autorelease];
    
    [listMessages addObject:@"Message1"];
    [listMessages addObject:@"Message2"];
    [listMessages addObject:@"Message3"];
    
    
    return listMessages;    
}

@end
