//
//  FbGraph.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/08/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FbGraphResponse.h"

@interface FbGraph : NSObject

@property (nonatomic, strong) NSString *facebookClientID;
@property (nonatomic, strong) NSString *redirectUri;
@property (nonatomic, strong) NSString *accessToken;

@property (nonatomic, weak) id callbackObject;
@property (nonatomic) SEL callbackSelector;

-(id)initWithFbClientID:fbcid;
-(FbGraphResponse*)doGraphGet:(NSString*)action withGetVars:(NSDictionary*)get_vars;
-(FbGraphResponse*)doGraphGetWithUrlString:(NSString*)url_string;
-(FbGraphResponse*)doGraphPost:(NSString*)action withPostVars:(NSDictionary*)post_vars;

+(BOOL)StoreShareid:(id)ids;

@end
