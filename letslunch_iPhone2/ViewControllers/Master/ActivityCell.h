//
//  ActivityCell.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 24/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *userPicture;
@property (nonatomic, strong) IBOutlet UILabel *labelUserName;
@property (nonatomic, strong) IBOutlet UILabel *labelUserJobTitle;
@property (nonatomic, strong) IBOutlet UILabel *labelVenueName;
@property (nonatomic, strong) IBOutlet UILabel *LabelTime;

@end
