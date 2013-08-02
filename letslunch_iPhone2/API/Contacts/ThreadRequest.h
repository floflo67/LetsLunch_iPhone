//
//  ThreadRequest.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 02/08/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThreadRequest : NSObject

+(NSMutableArray*)getListThreadsWithToken:(NSString*)token;
+(NSMutableArray*)getMessagesWithToken:(NSString*)token andThreadID:(NSString*)threadID;

@end
