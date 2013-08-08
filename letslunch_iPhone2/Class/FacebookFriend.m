//
//  FacebookFriend.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 02/08/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "FacebookFriend.h"

@interface FacebookFriend()
@property (nonatomic, strong, readwrite) NSString *userID;
@property (nonatomic, strong, readwrite) NSString *firstName;
@property (nonatomic, strong, readwrite) NSString *lastName;
@end

@implementation FacebookFriend

- (id)initWithID:(NSString*)userID firstname:(NSString*)firstname andLastname:(NSString*)lastname
{
    self = [super init];
    if(self) {
        self.userID = userID;
        self.firstName = firstname;
        self.lastName = lastname;
    }
    return self;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"id: %@, first name: %@, last name: %@", self.userID, self.firstName, self.lastName];
}

@end
