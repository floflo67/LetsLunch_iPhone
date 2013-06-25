//
//  Contacts.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 24/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contacts : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *pictureURL;
@property (nonatomic, strong) NSString *lastMessage;
@property (nonatomic, strong) NSMutableArray *listMessages;
@property (nonatomic, strong) UIImage *image;



-(id)initWithDict:(NSDictionary*)dict;
@end
