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

@implementation GetStaticLists

+ (NSArray*)getListActivities
{
    NSMutableArray* listActivities = [[[NSMutableArray alloc] init] autorelease];
    Messages *m = [[Messages alloc] initWithDescription:@"mess" From:@"1" To:@"2" date:[NSDate new]];
    Contacts *c = [[Contacts alloc] initWithID:@"1" withName:@"name" withPictureURL:nil andLastMessage:m];
    FSVenue *v = [[FSVenue alloc] init];
    
    v.name = @"The Grove";
    v.venueId = @"4b7ef75cf964a520ee0c30e3";
    v.location.address = @"690 Mission St";
    NSNumber *num = [NSNumber numberWithInt:403];
    v.location.distance = num;
    v.distance = v.location.distance;
    [v.location setCoordinate:CLLocationCoordinate2DMake([@"37.78653398485857" doubleValue], [@"-122.401921749115" doubleValue])];
    
    BOOL b = YES;
    Activity *act1 = [[Activity alloc] initWithContact:c venue:v description:@"desc1" andIsCoffee:b];
    
    [listActivities addObject:act1];
    [listActivities addObject:@"Activity2"];
    [listActivities addObject:@"Activity3"];
    
    return listActivities;
}

+ (Activity*)getOwnerActivity
{
    Messages *m = [[Messages alloc] initWithDescription:@"mess" From:@"1" To:@"2" date:[NSDate new]];
    Contacts *c = [[Contacts alloc] initWithID:@"1" withName:@"name" withPictureURL:nil andLastMessage:m];
    FSVenue *v = [[FSVenue alloc] init];
    
    v.name = @"The Grove";
    v.venueId = @"4b7ef75cf964a520ee0c30e3";
    v.location.address = @"690 Mission St";
    NSNumber *num = [NSNumber numberWithInt:403];
    v.location.distance = num;
    v.distance = v.location.distance;
    [v.location setCoordinate:CLLocationCoordinate2DMake([@"37.78653398485857" doubleValue], [@"-122.401921749115" doubleValue])];
    
    BOOL b = YES;
    Activity *act1 = [[Activity alloc] initWithContact:c venue:v description:@"descOwner" andIsCoffee:b];
    
    return act1;
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
    Messages *mess4 = [[Messages alloc] initWithDescription:@"content4" From:@"1" To:contactID date:[NSDate new]];
    Messages *mess5 = [[Messages alloc] initWithDescription:@"content5" From:@"1" To:contactID date:[NSDate new]];
    Messages *mess6 = [[Messages alloc] initWithDescription:@"content6" From:contactID To:@"1" date:[NSDate new]];
    Messages *mess7 = [[Messages alloc] initWithDescription:@"content7" From:contactID To:@"1" date:[NSDate new]];
    Messages *mess8 = [[Messages alloc] initWithDescription:@"content8" From:contactID To:@"1" date:[NSDate new]];
    Messages *mess9 = [[Messages alloc] initWithDescription:@"content9" From:contactID To:@"1" date:[NSDate new]];
    Messages *mess10 = [[Messages alloc] initWithDescription:@"content10" From:contactID To:@"1" date:[NSDate new]];
    Messages *mess11 = [[Messages alloc] initWithDescription:@"content11" From:contactID To:@"1" date:[NSDate new]];
    Messages *mess12 = [[Messages alloc] initWithDescription:@"content12" From:contactID To:@"1" date:[NSDate new]];
    
    [listMessages addObject:mess1];
    [listMessages addObject:mess2];
    [listMessages addObject:mess3];
    [listMessages addObject:mess4];
    [listMessages addObject:mess5];
    [listMessages addObject:mess6];
    [listMessages addObject:mess7];
    [listMessages addObject:mess8];
    [listMessages addObject:mess9];
    [listMessages addObject:mess10];
    [listMessages addObject:mess11];
    [listMessages addObject:mess12];
    
    
    return listMessages;    
}

+ (NSMutableArray*)getListContacts
{
    NSMutableArray* listContacts = [[[NSMutableArray alloc] init] autorelease];
    
    Contacts *cont1 = [[Contacts alloc] initWithID:@"1" withName:@"name1" withPictureURL:nil andLastMessage:nil];
    Contacts *cont2 = [[Contacts alloc] initWithID:@"2" withName:@"name2" withPictureURL:nil andLastMessage:nil];
    Contacts *cont3 = [[Contacts alloc] initWithID:@"3" withName:@"name3" withPictureURL:nil andLastMessage:nil];
    
    [listContacts addObject:cont1];
    [listContacts addObject:cont2];
    [listContacts addObject:cont3];
    
    
    return listContacts;
}

@end
