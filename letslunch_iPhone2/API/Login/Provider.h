//
//  TwitterProvider.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 02/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Provider : NSObject

@property (nonatomic, strong) NSString *apikey;
@property (nonatomic, strong) NSString *secretkey;

@property (nonatomic, strong) NSString *requestTokenURLString;
@property (nonatomic, strong) NSURL *requestTokenURL;

@property (nonatomic, strong) NSString *accessTokenURLString;
@property (nonatomic, strong) NSURL *accessTokenURL;

@property (nonatomic, strong) NSString *userLoginURLString;
@property (nonatomic, strong) NSURL *userLoginURL;

@property (nonatomic, strong) NSString *callbackURL;

-(id)initWithLinkedIn;
-(id)initWithTwitter;

@end
