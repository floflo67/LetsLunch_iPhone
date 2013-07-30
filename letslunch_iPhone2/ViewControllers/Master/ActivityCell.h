//
//  ActivityCell.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 24/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *userPicture;
@property (nonatomic, weak) IBOutlet UILabel *labelUserName;
@property (nonatomic, weak) IBOutlet UILabel *labelUserJobTitle;
@property (nonatomic, weak) IBOutlet UILabel *labelVenueName;
@property (nonatomic, weak) IBOutlet UILabel *LabelTime;

@end
