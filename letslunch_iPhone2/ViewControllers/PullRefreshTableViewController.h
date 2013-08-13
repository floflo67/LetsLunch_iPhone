//
//  PullRefreshTableViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 31/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

/*
 Class to manage the pull / refresh of a table view
 */
@interface PullRefreshTableViewController : UITableViewController

@property (nonatomic, strong, readonly) NSString *textPull;
@property (nonatomic, strong, readonly) NSString *textRelease;
@property (nonatomic, strong, readonly) NSString *textLoading;

-(void)stopLoading;
-(void)setTextLoading:(NSString*)textLoading textRelease:(NSString*)textRelease andTextPull:(NSString*)textPull;

@end
