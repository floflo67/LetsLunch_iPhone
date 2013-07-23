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

@property (nonatomic,assign) id<LunchRequestDelegate> delegate;

+(NSDictionary*)getLunchWithToken:(NSString*)token;
-(NSDictionary*)getLunchWithToken:(NSString*)token;
+(NSDictionary*)suppressLunchWithToken:(NSString*)token andActivityID:(NSString*)activityID;
-(NSDictionary*)suppressLunchWithToken:(NSString*)token andActivityID:(NSString*)activityID;
-(BOOL)addLunchWithToken:(NSString*)token andActivity:(Activity*)activity;
-(void)updateLunchWithToken:(NSString*)token andActivity:(Activity*)activity;

@end
