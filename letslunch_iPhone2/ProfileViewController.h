//
//  ProfileViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 11/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray* objects;

+(ProfileViewController*)getSingleton;

@end
