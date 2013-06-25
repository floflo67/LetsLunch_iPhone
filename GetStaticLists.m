//
//  GetStaticLists.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 13/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "GetStaticLists.h"
#import "Activity.h"
#import "Contacts.h"
#import "FSVenue.h"
#import "Messages.h"

@implementation GetStaticLists

+ (NSArray*)getListActivities
{
    NSMutableArray* listActivities = [[[NSMutableArray alloc] init] autorelease];
    //Messages *m = [[Messages alloc] initWithContent:@"mess" From:@"1" To:@"2" date:[NSDate new]];
    //Contacts *c = [[Contacts alloc] initWithID:@"1" withName:@"name" withPictureURL:nil andLastMessage:nil];
    //FSVenue *v = [[FSVenue alloc] init];
    //BOOL b = YES;
    //Activity *act1 = [[Activity alloc] initWithContact:nil venue:nil description:@"description" andIsCoffee:b];
    
    [listActivities addObject:@"Activity1"];
    [listActivities addObject:@"Activity2"];
    [listActivities addObject:@"Activity3"];
    
    
    return listActivities;
}

+ (NSString*)getOwnerActivity
{
    return @"ActivityOwner";
}


+ (NSMutableArray*)getListFriendsSuggestion
{
    NSMutableArray* listFriendsSuggestion = [[[NSMutableArray alloc] init] autorelease];
    
    [listFriendsSuggestion addObject:@"Suggestion1"];
    [listFriendsSuggestion addObject:@"Suggestion2"];
    [listFriendsSuggestion addObject:@"Suggestion3"];
    
    
    return listFriendsSuggestion;
}

+ (NSMutableArray*)getListMessagesForContactID:(NSString*)contactID
{
    NSMutableArray* listMessages = [[[NSMutableArray alloc] init] autorelease];
    
    Messages *mess1 = [[Messages alloc] initWithDescription:@"content1" From:contactID To:@"1" date:[NSDate new]];
    Messages *mess2 = [[Messages alloc] initWithDescription:@"content2" From:contactID To:@"1" date:[NSDate new]];
    Messages *mess3 = [[Messages alloc] initWithDescription:@"content3" From:contactID To:@"1" date:[NSDate new]];
    
    [listMessages addObject:mess1];
    [listMessages addObject:mess2];
    [listMessages addObject:mess3];
    
    
    return listMessages;    
}

+ (NSMutableArray*)getListContacts
{
    NSMutableArray* lastContacts = [[[NSMutableArray alloc] init] autorelease];
    
    Contacts *cont1 = [[Contacts alloc] initWithID:@"1" withName:@"name1" withPictureURL:nil andLastMessage:nil];
    Contacts *cont2 = [[Contacts alloc] initWithID:@"2" withName:@"name2" withPictureURL:nil andLastMessage:nil];
    Contacts *cont3 = [[Contacts alloc] initWithID:@"3" withName:@"name3" withPictureURL:nil andLastMessage:nil];
    
    [lastContacts addObject:cont1];
    [lastContacts addObject:cont2];
    [lastContacts addObject:cont3];
    
    
    return lastContacts;
}

@end
