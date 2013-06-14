//
//  SidebarViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SidebarViewControllerDelegate;

@interface SidebarViewController : UITableViewController

@property (nonatomic, assign) id <SidebarViewControllerDelegate> sidebarDelegate;
@property (nonatomic, strong) NSArray* menuItem;

@end

@protocol SidebarViewControllerDelegate <NSObject>

- (void)sidebarViewController:(SidebarViewController *)sidebarViewController didSelectObject:(float)object atIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSIndexPath *)lastSelectedIndexPathForSidebarViewController:(SidebarViewController *)sidebarViewController;

@end
