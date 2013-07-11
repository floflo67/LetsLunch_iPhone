//
//  ProfileRequest.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 11/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileRequest : NSObject {
    @private
        NSURLConnection* _connection;
        NSMutableData* _data;
        NSInteger _statusCode;
        NSMutableDictionary *_jsonDict;
}

-(NSDictionary*)getProfileWithToken:(NSString*)token;

@end
