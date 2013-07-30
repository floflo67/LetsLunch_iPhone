//
//  ThreadCell.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 25/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreadCell : UITableViewCell {
    NSString *msgText;
    NSString *imgName;
    NSString *dateText;
}

@property (nonatomic, strong) NSString *msgText;
@property (nonatomic, strong) NSString *imgName;
@property (nonatomic, strong) NSString *dateText;

@property (nonatomic, assign) BOOL tipRightward;

+(CGSize)calcTextHeight:(NSString*)str;
+(CGSize)calcTextHeight:(NSString*)str withinWidth:(CGFloat)width;

@end
