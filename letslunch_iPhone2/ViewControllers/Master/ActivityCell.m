//
//  ActivityCell.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 24/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "ActivityCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation ActivityCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setUserPicture:(UIImageView*)userPicture
{
    [self setRoundedView:userPicture toDiameter:self.frame.size.height];
    _userPicture = userPicture;
}

-(void)setRoundedView:(UIImageView*)roundedView toDiameter:(float)newSize;
{
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0;
    roundedView.center = saveCenter;
}

@end
