//
//  VisitorsRequest.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 19/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VisitorsRequest : NSObject {
    @private
        NSInteger _statusCode;
        NSMutableArray *_jsonArray;
}

-(NSArray*)getVisitorsWithToken:(NSString*)token;

@end
