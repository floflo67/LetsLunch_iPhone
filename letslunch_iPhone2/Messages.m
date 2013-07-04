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
        self.description = [dict objectForKey:@"description"];
        self.contactIDFrom = [dict objectForKey:@"from"];
        self.contactIDTo = [dict objectForKey:@"to"];
        self.date = [dict objectForKey:@"date"];
    }
    return self;
}

- (id)initWithDescription:(NSString*)description From:(NSString*)from To:(NSString*)to date:(NSDate*)date
{
    self = [self init];
    if(self) {
        self.description = description;
        self.contactIDFrom = from;
        self.contactIDTo = to;
        self.date = date;
    }
    return self;
}

- (void)dealloc
{
    [self.description release];
    [self.contactIDFrom release];
    [self.contactIDTo release];
    [self.date release];
    [super dealloc];
}

@end
