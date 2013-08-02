//
//  ProfileViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 11/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

+(ProfileViewController*)getSingleton;
+(void)suppressSingleton;

@end
