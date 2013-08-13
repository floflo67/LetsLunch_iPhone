//
//  ActivityCell.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 24/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

@interface ActivityCell : UITableViewCell

-(void)setUserName:(NSString*)userName jobTitle:(NSString*)jobTitle venueName:(NSString*)venueName time:(NSString*)time andPicture:(UIImage*)picture;
-(void)loadTextColor;
-(void)hideView;
-(void)showView;

@end
