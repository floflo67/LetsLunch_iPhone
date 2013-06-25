//
//  ContactViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 25/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray* objects;

+(ContactViewController*)getSingleton;

@end
