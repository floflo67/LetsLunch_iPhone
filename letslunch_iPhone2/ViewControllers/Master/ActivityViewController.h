//
//  ActivityViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableViewController.h"

@interface ActivityViewController : PullRefreshTableViewController

-(void)loadOwnerActivity;

+(ActivityViewController*)getSingleton;
+(void)suppressSingleton;

@end
