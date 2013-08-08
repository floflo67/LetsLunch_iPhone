//
//  FacebookShare.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/08/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "FacebookShare.h"
#import <FacebookSDK/FacebookSDK.h>

#define DICT_SIZE 5
#define FB_LINK_KEY @"link"
#define FB_NAME_KEY @"name"
#define FB_PICTURE_KEY @"picture"
#define FB_CAPTION_KEY @"caption"
#define FB_DESCRIPTION_KEY @"description"
#define FB_SHARE_CAPTION @"Look at my lunch on letslunch.com"
#define FB_SHARE_DESCRIPTION  @"I'm available for a lunch. Check it out on letslunch.com"
#define FB_SHARED_ALERT @"Shared on Facebook"

@interface FacebookShare()
@property (nonatomic, strong) NSString *feedPostId;
@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSString *modelLink;
@property (nonatomic, strong) NSString *modelImageUrl;
@end

@implementation FacebookShare
@synthesize delegate;
-(id)init
{
    return [super init];
}

-(void)postToFacebook:(NSString*)name productLink:(NSString*)productLink productImageUrl:(NSString*)imageUrl
{
    self.modelName = name;
    self.modelLink = productLink;
    self.modelImageUrl = imageUrl;
    
    NSString *clientID = FB_OAUTH_KEY;
    
    fbGraph = [[FbGraph alloc] initWithFbClientID:clientID];
    
    [FBSession.activeSession closeAndClearTokenInformation];
    
    [FBSession openActiveSessionWithReadPermissions:@[@"email"] allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
        if(session.isOpen) {
            [FBSession openActiveSessionWithPublishPermissions:@[@"publish_actions"] defaultAudience:FBSessionDefaultAudienceEveryone allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                if(session.isOpen) {
                    fbGraph.accessToken = session.accessTokenData.accessToken;
                    [self shareOnFacebook];
                }
            }];
        }
    }];
    
    [FbGraph StoreShareid:self];
}

-(void)shareOnFacebook;
{
    NSMutableDictionary *variables = [NSMutableDictionary dictionaryWithCapacity:DICT_SIZE];
    [variables setObject:self.modelLink forKey:FB_LINK_KEY];
    [variables setObject:self.modelName forKey:FB_NAME_KEY];
    if(self.modelImageUrl)
        [variables setObject:self.modelImageUrl forKey:FB_PICTURE_KEY];
    
    [variables setObject:FB_SHARE_CAPTION forKey:FB_CAPTION_KEY];
    [variables setObject:FB_SHARE_DESCRIPTION forKey:FB_DESCRIPTION_KEY];
    
    FbGraphResponse *fb_graph_response = [fbGraph doGraphPost:@"me/feed" withPostVars:variables];
    if(fb_graph_response.error) {
        NSLog(@"ERROR");
    }
    
    //parse our json
    NSLog(@"toto: %@", fb_graph_response.htmlResponse);
    /*
    SBJSON *parser = [[SBJSON alloc] init];
    NSDictionary *facebook_response = [parser objectWithString:fb_graph_response.htmlResponse error:nil];*/
}

@end
