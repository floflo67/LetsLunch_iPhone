//
//  FbGraphResponse.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/08/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FbGraphResponse : NSObject

@property (nonatomic, strong) NSString *htmlResponse;
@property (nonatomic, strong) UIImage *imageResponse;
@property (nonatomic, strong) NSError *error;

@end
