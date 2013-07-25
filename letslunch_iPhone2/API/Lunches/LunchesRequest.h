//
//  LunchesRequest.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 17/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LunchRequestDelegate
-(void)showErrorMessage:(NSString*)message withErrorStatus:(NSInteger)errorStatus;
@end

@interface LunchesRequest : NSObject {
    @private
        id<LunchRequestDelegate> _delegate;
        NSURLConnection* _connection;
        NSMutableData* _data;
        NSInteger _statusCode;
        NSMutableDictionary *_jsonDict;
}

@property (nonatomic, strong) id<LunchRequestDelegate> delegate;

+(NSDictionary*)getOwnerLunchWithToken:(NSString*)token;
-(NSDictionary*)getOwnerLunchWithToken:(NSString*)token;

+(NSMutableArray*)getLunchesWithToken:(NSString*)token latitude:(double)latitude longitude:(double)longitude andDate:(NSString*)date;
-(NSMutableArray*)getLunchesWithToken:(NSString*)token latitude:(double)latitude longitude:(double)longitude andDate:(NSString*)date;

+(BOOL)suppressLunchWithToken:(NSString*)token andActivityID:(NSString*)activityID;
-(BOOL)suppressLunchWithToken:(NSString*)token andActivityID:(NSString*)activityID;

-(NSDictionary*)addLunchWithToken:(NSString*)token andActivity:(Activity*)activity;
-(void)updateLunchWithToken:(NSString*)token andActivity:(Activity*)activity;

@end
