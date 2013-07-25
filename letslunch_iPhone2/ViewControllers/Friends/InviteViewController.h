//
//  InviteViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 15/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InviteViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    @private
        NSArray *objects;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
