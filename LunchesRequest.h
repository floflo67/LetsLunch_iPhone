//
//  LunchesRequest.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 17/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LunchesRequest : NSObject {
    @private
        NSInteger _statusCode;
        NSMutableDictionary *_jsonDict;
}

+(NSDictionary*)getLunchWithToken:(NSString*)token;
-(NSDictionary*)getLunchWithToken:(NSString*)token;
+(NSDictionary*)suppressLunchWithToken:(NSString*)token andDate:(NSString*)date;
-(NSDictionary*)suppressLunchWithToken:(NSString*)token andDate:(NSString*)date;

@end
