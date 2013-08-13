//
//  Thread.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 02/08/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "Contacts.h"

@interface Thread : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) Contacts *receiver;
@property (nonatomic, strong) Messages *lastMessage;
@property (nonatomic, strong) NSString *type;

@end
