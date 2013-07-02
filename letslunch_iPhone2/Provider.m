//
//  TwitterProvider.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 02/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "Provider.h"

@implementation Provider

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)initWithLinkedIn
{
    self = [super init];
    if (self) {
        _apikey = LI_OAUTH_KEY;
        _secretkey = LI_OAUTH_SECRET;
        
        _requestTokenURLString = @"https://api.linkedin.com/uas/oauth/requestToken";
        _accessTokenURLString = @"https://api.linkedin.com/uas/oauth/accessToken";
        _userLoginURLString = @"https://www.linkedin.com/uas/oauth/authorize";
        _callbackURL = @"hdlinked://linkedin/oauth";
        
        _requestTokenURL = [[NSURL URLWithString:_requestTokenURLString] retain];
        _accessTokenURL = [[NSURL URLWithString:_accessTokenURLString] retain];
        _userLoginURL = [[NSURL URLWithString:_userLoginURLString] retain];
    }
    return self;
}

- (id)initWithTwitter
{
    self = [super init];
    if (self) {
        _apikey = TW_OAUTH_KEY;
        _secretkey = TW_OAUTH_SECRET;
        
        _requestTokenURLString = @"https://api.twitter.com/oauth/request_token";
        _accessTokenURLString = @"https://api.twitter.com/oauth/access_token";
        _userLoginURLString = @"https://api.twitter.com/oauth/authenticate";
        _callbackURL = @"hdlinked://linkedin/oauth";
        
        _requestTokenURL = [[NSURL URLWithString:_requestTokenURLString] retain];
        _accessTokenURL = [[NSURL URLWithString:_accessTokenURLString] retain];
        _userLoginURL = [[NSURL URLWithString:_userLoginURLString] retain];
    }
    return self;
}

@end
