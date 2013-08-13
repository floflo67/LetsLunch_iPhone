//
//  LunchesRequest.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 17/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

@interface LunchesRequest : NSObject

+(NSDictionary*)getOwnerLunchWithToken:(NSString*)token;
+(NSMutableArray*)getLunchesWithToken:(NSString*)token latitude:(double)latitude longitude:(double)longitude andDate:(NSString*)date;
+(BOOL)suppressLunchWithToken:(NSString*)token andActivityID:(NSString*)activityID;

-(NSDictionary*)addLunchWithToken:(NSString*)token andActivity:(Activity*)activity;
-(void)updateLunchWithToken:(NSString*)token andActivity:(Activity*)activity;

@end
