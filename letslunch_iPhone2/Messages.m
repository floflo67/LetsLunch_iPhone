//
//  Messages.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 24/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "Messages.h"

@implementation Messages

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
        self.content = [dict objectForKey:@"content"];
        self.contactIDFrom = [dict objectForKey:@"from"];
        self.contactIDTo = [dict objectForKey:@"to"];
        self.date = [dict objectForKey:@"date"];
    }
    return self;
}

@end
