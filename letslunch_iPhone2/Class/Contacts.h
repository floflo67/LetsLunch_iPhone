//
//  Contacts.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 24/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "Messages.h"

@interface Contacts : NSObject

@property (nonatomic, strong, readonly) NSString *ID;
@property (nonatomic, strong, readonly) NSString *firstname;
@property (nonatomic, strong, readonly) NSString *lastname;
@property (nonatomic, strong, readonly) NSString *jobTitle;
@property (nonatomic, strong, readonly) NSString *pictureURL;
@property (nonatomic, strong, readonly) NSMutableArray *listMessages;
@property (nonatomic, strong, readonly) UIImage *image;
@property (nonatomic, readonly) BOOL onWishlist;

-(id)initWithDictionary:(NSDictionary*)dict;
-(id)initWithID:(NSString*)ID firstname:(NSString*)firstname lastname:(NSString*)lastname jobTitle:(NSString*)jobTitle onWishlist:(BOOL)onWishlist andPictureURL:(NSString*)url;
-(void)setImage:(UIImage*)image;

@end
