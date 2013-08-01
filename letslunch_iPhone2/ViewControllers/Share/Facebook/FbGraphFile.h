//
//  FbGraphImage.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/08/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FbGraphFile : NSObject

@property (nonatomic, retain) UIImage *uploadImage;

-(id)initWithImage:(UIImage*)upload_image;
-(void)appendDataToBody:(NSMutableData*)body;

@end
