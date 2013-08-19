//
//  ActivityCell.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 24/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "ActivityCell.h"

@interface ActivityCell()
@property (nonatomic, weak) IBOutlet UIImageView *userPicture;
@property (nonatomic, weak) IBOutlet UILabel *labelUserName;
@property (nonatomic, weak) IBOutlet UILabel *labelUserJobTitle;
@property (nonatomic, weak) IBOutlet UILabel *labelVenueName;
@property (nonatomic, weak) IBOutlet UILabel *LabelTime;
@end

@implementation ActivityCell

#pragma mark - sets texts

-(void)setUserName:(NSString*)userName jobTitle:(NSString*)jobTitle venueName:(NSString*)venueName time:(NSString*)time
{
    self.labelUserJobTitle.text = jobTitle;
    self.LabelTime.text = time;
    self.labelUserName.text = userName;
    if(![venueName isEqualToString:@"Custom venue"])
        self.labelVenueName.text = venueName;
    else
        self.labelVenueName.text = @"";
}

- (void)setPicture:(UIImage*)image
{
    self.userPicture.image = image;
}

#pragma mark - Design color

- (void)loadTextColor
{
    self.labelUserJobTitle.textColor = [AppDelegate colorWithHexString:@"f88836"];
    self.LabelTime.textColor = [AppDelegate colorWithHexString:@"5e5e5e"];
    self.labelUserName.textColor = [AppDelegate colorWithHexString:@"6a6a6a"];
    self.labelVenueName.textColor = [AppDelegate colorWithHexString:@"5e5e5e"];
}

#pragma mark - show and hide

- (void)hideView
{
    self.userPicture.hidden = YES;
    self.labelUserJobTitle.hidden = YES;
    self.LabelTime.hidden = YES;
    self.labelUserName.hidden = YES;
    self.labelVenueName.hidden = YES;
}

- (void)showView
{
    self.userPicture.hidden = NO;
    self.labelUserJobTitle.hidden = NO;
    self.LabelTime.hidden = NO;
    self.labelUserName.hidden = NO;
    self.labelVenueName.hidden = NO;
}

@end
