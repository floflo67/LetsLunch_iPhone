//
//  WishListRequest.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 08/08/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WishListRequest : NSObject

+(void)changeUserFromWishList:(NSString*)userID withToken:(NSString*)token;

@end
