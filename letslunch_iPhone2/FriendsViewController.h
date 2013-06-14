//
//  FriendsViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray* objects;

+(FriendsViewController*)getSingleton;

@end
