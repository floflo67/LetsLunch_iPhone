//
//  Activity.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 24/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "Activity.h"

@implementation Activity

- (id)init
{
    self = [super init];
    if(self) {
        
    }
    return self;
}

- (id)initWithDict:(NSDictionary*)dict
{
    self = [self init];
    if(self) {
        self.contact = [dict objectForKey:@"contact"];
        self.venue = [dict objectForKey:@"venue"];
        self.isCoffee = [[dict objectForKey:@"isCoffee"] boolValue];
        self.description = [dict objectForKey:@"description"];
    }
    return self;
}

@end
