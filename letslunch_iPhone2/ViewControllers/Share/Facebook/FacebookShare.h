//
//  FacebookShare.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/08/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FbGraph.h"

@protocol facebookShareDelegate <NSObject>

@optional
-(void)showALert:(NSString *)message;

@end

@interface FacebookShare : NSObject
{
    FbGraph *fbGraph;
    __unsafe_unretained id <facebookShareDelegate> delegate;
}

@property (nonatomic, assign) id <facebookShareDelegate> delegate;

-(void)postToFacebook:(NSString *)name productLink:(NSString *)productLink productImageUrl:(NSString *)imageUrl;
-(void)shareOnFacebook;

@end
