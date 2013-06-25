//
//  AppDelegate.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CenterViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CenterViewController *viewController;

@property (strong, nonatomic) NSMutableArray *listActivities;
@property (strong, nonatomic) NSMutableArray *listFriendsSuggestion;
@property (strong, nonatomic) NSMutableArray *listMessages;
@property (strong, nonatomic) NSMutableArray *listContacts;
@property (strong, nonatomic) NSString *ownerActivity;

-(NSMutableArray*)getListActivities;
-(NSMutableArray*)getListFriendsSuggestion;
-(NSMutableArray*)getListMessagesForContactID:(NSString*)contactID;
-(NSMutableArray*)getListContacts;
-(NSString*)getOwnerActivity;

+(UIColor*)colorWithHexString:(NSString*)hex;
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

@end
