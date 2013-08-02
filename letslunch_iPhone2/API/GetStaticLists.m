//
//  GetStaticLists.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 13/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "GetStaticLists.h"
#import "Contacts.h"
#import "FSVenue.h"
#import "Messages.h"
#import "LunchesRequest.h"
#import "VisitorsRequest.h"
#import "ThreadRequest.h"

@implementation GetStaticLists

+ (NSMutableArray*)getListActivitiesWithToken:(NSString*)token latitude:(double)latitude longitude:(double)longitude andDate:(NSString*)date
{
    return [LunchesRequest getLunchesWithToken:token latitude:latitude longitude:longitude andDate:date];
}

+ (Activity*)getOwnerActivityWithToken:(NSString*)token
{
    NSDictionary *dict = [LunchesRequest getOwnerLunchWithToken:token];
    if(!dict)
        return nil;
    else
        return [[Activity alloc] initWithDict:dict];
}


+ (NSMutableArray*)getListFriendsSuggestion
{
    NSMutableArray* listFriendsSuggestion = [[NSMutableArray alloc] init];
    
    [listFriendsSuggestion addObject:@"Suggestion1"];
    [listFriendsSuggestion addObject:@"Suggestion2"];
    [listFriendsSuggestion addObject:@"Suggestion3"];
    return listFriendsSuggestion;
}

+ (NSMutableArray*)getListMessagesForContactID:(NSString*)contactID
{
    return [ThreadRequest getMessagesWithToken:[AppDelegate getToken] andThreadID:contactID];
}

+ (NSMutableArray*)getListVisitors
{
    NSMutableArray* listVisitors = [[NSMutableArray alloc] init];
    listVisitors = [VisitorsRequest getVisitorsWithToken:[AppDelegate getToken]];
    return listVisitors;
}

+ (NSMutableArray*)getListContacts
{
    NSMutableArray* listContacts = [[NSMutableArray alloc] initWithArray:[ThreadRequest getListThreadsWithToken:[AppDelegate getToken]]];
    if(listContacts)
        return listContacts;
    else
        return nil;
}

@end
