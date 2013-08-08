//
//  Testimonials.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 08/08/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "Testimonials.h"

@interface Testimonials()
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) Contacts *user;
@end

@implementation Testimonials

- (id)initWithDictionary:(NSDictionary*)dict
{
    self = [super self];
    if(self) {
        self.message = [dict objectForKey:@"message"];
        self.user = [[Contacts alloc] initWithDictionary:[dict objectForKey:@"user"]];
    }
    return self;
}

@end
