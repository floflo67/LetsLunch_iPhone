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
@property (nonatomic, strong) NSString *publicname;
@property (nonatomic, strong) NSString *headline;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *pictureURL;
@property (nonatomic, strong) NSMutableArray *listMessages;
@property (nonatomic, strong) UIImage *image;

-(id)initWithDict:(NSDictionary*)dict;
-(id)initWithID:(NSString*)ID firstname:(NSString*)firstname lastname:(NSString*)lastname publicname:(NSString*)publicname summary:(NSString*)summary headline:(NSString*)headline andPictureURL:(NSString*)url;

@end
