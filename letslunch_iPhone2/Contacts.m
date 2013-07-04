//
//  Contacts.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 24/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "Contacts.h"

@implementation Contacts

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
        self.ID = [dict objectForKey:@"id"];
        self.name = [dict objectForKey:@"name"];
        self.pictureURL = [dict objectForKey:@"pictureURL"];
        self.lastMessage = [dict objectForKey:@"last"];
        
        if(self.pictureURL)
            self.image = [UIImage imageWithContentsOfFile:[NSString stringWithContentsOfURL:[NSURL URLWithString:self.pictureURL] encoding:NSUTF8StringEncoding error:nil]];
    }
    return self;
}

- (id)initWithID:(NSString*)ID withName:(NSString*)name withPictureURL:(NSString*)url andLastMessage:(Messages*)mess
{
    self = [self init];
    if(self) {
        self.ID = ID;
        self.name = name;
        self.pictureURL = url;
        self.lastMessage = mess.description;
        
        if(self.pictureURL)
            self.image = [UIImage imageWithContentsOfFile:[NSString stringWithContentsOfURL:[NSURL URLWithString:self.pictureURL] encoding:NSUTF8StringEncoding error:nil]];
    }
    return self;
}

- (void)setMessages:(NSArray*)list
{
    NSArray *sortedArray = [list sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSDate *first = [(Messages*)a date];
        NSDate *second = [(Messages*)b date];
        return [first compare:second];
    }];
    self.listMessages = (NSMutableArray*)sortedArray;
}

- (void)dealloc
{
    [self.ID release];
    [self.name release];
    [self.pictureURL release];
    [self.lastMessage release];
    [self.listMessages release];
    [self.image release];
    [super dealloc];
}

@end
