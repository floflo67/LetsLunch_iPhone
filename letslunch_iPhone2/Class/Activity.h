//
//  Activity.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 24/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "FSVenue.h"
#import "Contacts.h"

@interface Activity : NSObject

@property (nonatomic, strong, readonly) NSString *activityID;
@property (nonatomic, strong, readonly) Contacts *contact;
@property (nonatomic, strong, readonly) NSString *description;
@property (nonatomic, strong, readonly) NSString *time;
@property (nonatomic, strong, readonly) FSVenue *venue;
@property (nonatomic, readonly) BOOL isCoffee;

-(id)initWithDict:(NSDictionary*)dict;
-(id)initWithID:(NSString*)activityID contact:(Contacts*)contact venue:(FSVenue*)venue description:(NSString*)description startTime:(NSString*)startTime endTime:(NSString*)endTime andIsCoffee:(BOOL)isCoffee;
-(void)setDescription:(NSString*)description isCoffee:(BOOL)isCoffee venue:(FSVenue*)venue andTime:(NSString*)time;
-(void)setContact:(Contacts*)contact;
-(void)setActivityID:(NSString*)activityID;

@end
