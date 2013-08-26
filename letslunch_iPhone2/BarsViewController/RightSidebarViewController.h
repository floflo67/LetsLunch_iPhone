//
//  RightSidebarViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 18/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

@protocol RightSidebarViewControllerDelegate;

@interface RightSidebarViewController : UITableViewController
@property (nonatomic, weak) id <RightSidebarViewControllerDelegate> sidebarDelegate;

-(void)changeShareButton;

@end

@protocol RightSidebarViewControllerDelegate <NSObject>

-(void)sidebarViewController:(RightSidebarViewController*)sidebarViewController didSelectObject:(float)object atIndexPath:(NSIndexPath*)indexPath;

@optional
-(NSIndexPath*)lastSelectedIndexPathForSidebarViewController:(RightSidebarViewController*)sidebarViewController;

@end