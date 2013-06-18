//
//  SidebarViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftSidebarViewControllerDelegate;

@interface LeftSidebarViewController : UITableViewController

@property (nonatomic, assign) id <LeftSidebarViewControllerDelegate> sidebarDelegate;
@property (nonatomic, strong) NSArray* menuItem;

@end

@protocol LeftSidebarViewControllerDelegate <NSObject>

- (void)sidebarViewController:(LeftSidebarViewController *)sidebarViewController didSelectObject:(NSObject*)object atIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSIndexPath *)lastSelectedIndexPathForSidebarViewController:(LeftSidebarViewController *)sidebarViewController;

@end
