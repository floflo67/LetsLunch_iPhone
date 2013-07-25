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

- (id)initWithDictionary:(NSDictionary*)dict
{
    self = [self init];
    if(self) {
        self.ID = [dict objectForKey:@"uid"];
        self.firstname = [dict objectForKey:@"firstname"];
        if(!self.firstname)
            self.firstname = @"";
        
        self.lastname = [dict objectForKey:@"lastname"];
        if(!self.lastname || [self.lastname.class isSubclassOfClass:[NSNull class]])
            self.lastname = @"";
        
        self.jobTitle = [dict objectForKey:@"headline"];
        if(!self.jobTitle || [self.jobTitle.class isSubclassOfClass:[NSNull class]])
            self.jobTitle = @"";
        
        self.pictureURL = [dict objectForKey:@"pictureURL"];
        if(!self.pictureURL)
            self.pictureURL = nil;
        
        
        if(self.pictureURL)
            self.image = [UIImage imageWithContentsOfFile:[NSString stringWithContentsOfURL:[NSURL URLWithString:self.pictureURL] encoding:NSUTF8StringEncoding error:nil]];
    }
    return self;
}

- (id)initWithID:(NSString*)ID firstname:(NSString*)firstname lastname:(NSString*)lastname jobTitle:(NSString*)jobTitle andPictureURL:(NSString*)url
{
    self = [self init];
    if(self) {
        self.ID = ID;
        self.firstname = firstname;
        self.lastname = lastname;
        self.jobTitle = jobTitle;
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
