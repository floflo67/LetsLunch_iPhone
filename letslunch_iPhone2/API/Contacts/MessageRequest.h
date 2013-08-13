//
//  MessageRequest.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 29/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

@interface MessageRequest : NSObject

+(void)sendMessage:(NSString*)message withToken:(NSString*)token toUser:(NSString*)userID;
+(void)sendMessage:(NSString*)message withToken:(NSString*)token toThread:(NSString*)threadID;

@end
