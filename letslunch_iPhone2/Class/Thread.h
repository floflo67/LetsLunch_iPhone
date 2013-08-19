//
//  Thread.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 02/08/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "Contacts.h"

@interface Thread : NSObject

@property (nonatomic, strong, readonly) NSString *ID;
@property (nonatomic, strong, readonly) Contacts *receiver;
@property (nonatomic, strong, readonly) Messages *lastMessage;
@property (nonatomic, strong, readonly) NSString *type;

-(id)initWithID:(NSString*)ID receiver:(Contacts*)receiver lastMessage:(Messages*)lastMessage andType:(NSString*)type;

@end
