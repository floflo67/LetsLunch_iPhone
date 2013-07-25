//
//  Activity.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 24/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "Activity.h"

@implementation Activity

- (id)initWithDict:(NSDictionary*)dict
{
    self = [self init];
    if(self) {
        self.activityID = [dict objectForKey:@"id"];
        
        self.contact = [[Contacts alloc] initWithDictionary:[dict objectForKey:@"contact"]];
        self.venue = [[FSVenue alloc] initWithDictionary:[dict objectForKey:@"venue"]];
        
        self.time = [NSString stringWithFormat:@"%@ - %@", [dict objectForKey:@"startTime"], [dict objectForKey:@"endTime"]];
        if(!self.time)
            self.time = @"3:00 PM - 4:00 PM";
        
        self.isCoffee = [[dict objectForKey:@"isCoffee"] boolValue];
        
        self.description = [dict objectForKey:@"description"];
        if(!self.description)
            self.description = @"";
        
    }
    return self;
}

- (id)initWithID:(NSString *)activityID contact:(Contacts *)contact venue:(FSVenue *)venue description:(NSString *)description startTime:(NSString*)startTime endTime:(NSString*)endTime andIsCoffee:(BOOL)isCoffee
{
    self = [self init];
    if(self) {
        self.activityID = activityID;
        self.contact = contact;
        self.venue = venue;
        self.time = [NSString stringWithFormat:@"%@ - %@", startTime, endTime];
        self.isCoffee = isCoffee;
        self.description = description;
    }
    return self;
}

@end
