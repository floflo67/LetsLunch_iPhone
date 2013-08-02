//
//  Contacts.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 24/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Messages.h"

@interface Contacts : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *firstname;
@property (nonatomic, strong) NSString *lastname;
@property (nonatomic, strong) NSString *jobTitle;
@property (nonatomic, strong) NSString *pictureURL;
@property (nonatomic, strong) NSMutableArray *listMessages;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic) BOOL onWishlist;

-(id)initWithDictionary:(NSDictionary*)dict;
-(id)initWithID:(NSString*)ID firstname:(NSString*)firstname lastname:(NSString*)lastname jobTitle:(NSString*)jobTitle onWishlist:(BOOL)onWishlist andPictureURL:(NSString*)url;

@end
