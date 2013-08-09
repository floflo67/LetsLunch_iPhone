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
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjects:[[dict objectForKey:@"user"] allValues] forKeys:[[dict objectForKey:@"user"] allKeys]];
        [dictionary setObject:[dictionary objectForKey:@"id"] forKey:@"uid"];
        [dictionary setObject:[dictionary objectForKey:@"pictureUrl"] forKey:@"pictureURL"];
        [dictionary removeObjectForKey:@"id"];
        [dictionary removeObjectForKey:@"pictureUrl"];
        self.user = [[Contacts alloc] initWithDictionary:dictionary];
    }
    return self;
}

@end
