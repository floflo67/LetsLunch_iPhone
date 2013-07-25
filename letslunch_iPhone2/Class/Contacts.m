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
        self.ID = [dict objectForKey:@"uid"];
        self.firstname = [dict objectForKey:@"firstname"];
        self.lastname = [dict objectForKey:@"lastname"];
        self.publicname = [dict objectForKey:@"publicname"];
        self.summary = [dict objectForKey:@"headline"];
        self.headline = [dict objectForKey:@"summary"];
        self.pictureURL = [dict objectForKey:@"pictureURL"];
        
        if(self.pictureURL)
            self.image = [UIImage imageWithContentsOfFile:[NSString stringWithContentsOfURL:[NSURL URLWithString:self.pictureURL] encoding:NSUTF8StringEncoding error:nil]];
    }
    return self;
}

- (id)initWithID:(NSString*)ID firstname:(NSString*)firstname lastname:(NSString*)lastname publicname:(NSString*)publicname summary:(NSString*)summary headline:(NSString*)headline andPictureURL:(NSString*)url
{
    self = [self init];
    if(self) {
        self.ID = ID;
        self.firstname = firstname;
        self.lastname = lastname;
        self.publicname = publicname;
        self.summary = summary;
        self.headline = headline;
        self.pictureURL = url;
        
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

@end
