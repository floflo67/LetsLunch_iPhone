//
//  Thread.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 02/08/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "Thread.h"

@interface Thread()
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) Contacts *receiver;
@property (nonatomic, strong) Messages *lastMessage;
@property (nonatomic, strong) NSString *type;

@end

@implementation Thread

- (id)initWithID:(NSString*)ID receiver:(Contacts*)receiver lastMessage:(Messages*)lastMessage andType:(NSString*)type
{
    self = [super init];
    if(self) {
        self.ID = ID;
        self.receiver = receiver;
        self.lastMessage = lastMessage;
        self.type = type;
    }
    return self;
}

@end
