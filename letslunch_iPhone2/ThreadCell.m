//
//  ThreadCell.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 25/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "ThreadCell.h"


@implementation ThreadCell
@synthesize msgText;
@synthesize imgName;
@synthesize dateText;
@synthesize tipRightward = _tipRightward;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        self.accessoryType   = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews
{
    /*
     cell.tipRightWard = YES => message to user
     */
    [super layoutSubviews];
    CGFloat widthForText = self.bounds.size.width - 50;
    CGSize size = [ThreadCell calcTextHeight:self.msgText withinWidth:widthForText];
    
    /*
     Sets image for background
     Turns it around if needed
     */
    UIImage *balloon = [[UIImage imageNamed:self.imgName] stretchableImageWithLeftCapWidth:24 topCapHeight:15];
    if (self.tipRightward) {
        balloon = [UIImage imageWithCGImage: balloon.CGImage scale:1.0 orientation:(UIImageOrientationUpMirrored)];
        balloon = [balloon stretchableImageWithLeftCapWidth:24 topCapHeight:15];
    }
    
    /*
     Resize image and view to fit
     */
    CGFloat x;
    if (self.tipRightward)
        x = 0.0f;
    else
        x = self.frame.size.width - size.width - 24 - 10 ;
    UIImageView *newImage = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0.0, size.width + 35, size.height + 10)];
    UIView *newView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
    
    /*
     Sets label to contain text
     Contains message text
     */
    UILabel *txtLabel = [[UILabel alloc] initWithFrame:CGRectMake(x + 7, 2, size.width - 3, size.height - 2)];
    txtLabel.lineBreakMode = NSLineBreakByWordWrapping;
    txtLabel.numberOfLines = 0;
    txtLabel.text = msgText;
    txtLabel.backgroundColor = [UIColor clearColor];
    txtLabel.font = [UIFont systemFontOfSize:16.0];
    txtLabel.tag = 42;
    
    /*
     Sets label to contain date
     */
    
    UILabel *dateLabel = [[UILabel alloc] init];
    if(self.tipRightward)
        dateLabel.frame = CGRectMake(size.width + 30, 5, 40, size.height);
    else
        dateLabel.frame = CGRectMake(x - 45, 5, 40, size.height);
    dateLabel.numberOfLines = 1;
    dateLabel.text = dateText;
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.textColor = [UIColor lightGrayColor];
    dateLabel.font = [UIFont systemFontOfSize:12.0];
    dateLabel.tag = 41;
    
    /*
     Add every view to content
     */
    [txtLabel sizeToFit];
    [newImage setImage:balloon];
    [newView addSubview:newImage];
    [self setBackgroundView:newView];
    [[self.contentView viewWithTag:42] removeFromSuperview];
    [self.contentView addSubview:txtLabel];
    [[self.contentView viewWithTag:41] removeFromSuperview];
    [self.contentView addSubview:dateLabel];
    
    /*
     Release allocated resources
     */
    dateLabel = nil;
    txtLabel = nil;
    newImage = nil;
    newView = nil;
}

+ (CGSize)calcTextHeight:(NSString *)str
{
    return [self calcTextHeight:str withinWidth:300.0];
}

/*
 Returns size needed to contain a certain string
 */
+ (CGSize)calcTextHeight:(NSString *)str withinWidth:(CGFloat)width
{
    CGSize textSize = {width - 30, 20000.0};
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:16.0] constrainedToSize:textSize];
    size.width += 10;
    return size;
}

- (void)dealloc
{
    msgText = nil;
    imgName = nil;
    [super dealloc];
}


@end
