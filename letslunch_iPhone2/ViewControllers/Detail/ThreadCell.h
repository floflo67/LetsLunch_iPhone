//
//  ThreadCell.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 25/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

@interface ThreadCell : UITableViewCell

+(CGSize)calcTextHeight:(NSString*)str;
+(CGSize)calcTextHeight:(NSString*)str withinWidth:(CGFloat)width;

-(void)setMessage:(NSString*)message andDate:(NSString*)date;
-(void)setImageName:(NSString*)imageName andTipRightward:(BOOL)tipRightward;

@end
