//
//  AppDelegate.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CenterViewController.h"
#import "LoginViewController.h"
#import "Activity.h"
#import "KeychainWrapper.h"
#import "Contacts.h"

@class TwitterConsumer;
@class TwitterToken;

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) CenterViewController *viewController;
@property (nonatomic, strong) UINavigationController *navController;
@property (nonatomic, strong) Activity *ownerActivity;
@property (nonatomic, strong) Contacts *ownerContact;
@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) TwitterConsumer* consumer;
@property (nonatomic, strong) TwitterToken* token;

-(NSMutableArray*)getListActivitiesAndForceReload:(BOOL)shouldReload;
-(NSMutableArray*)getListFriendsSuggestionAndForceReload:(BOOL)shouldReload;
-(NSMutableArray*)getListVisitorsAndForceReload:(BOOL)shouldReload;
-(NSMutableArray*)getListMessagesForThreadID:(NSString*)threadID andForceReload:(BOOL)shouldReload;
-(NSMutableArray*)getListContactsAndForceReload:(BOOL)shouldReload;
-(Activity*)getOwnerActivityAndForceReload:(BOOL)shouldReload;

-(void)loginSuccessfull;
-(void)hideLoginView;

-(NSString*)getToken;
-(void)writeObjectToKeychain:(id)object forKey:(id)key;
-(id)getObjectFromKeychainForKey:(id)key;
-(void)logout;

+(NSString*)getToken;
+(UIColor*)colorWithHexString:(NSString*)hex;
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
+(void)writeObjectToKeychain:(id)object forKey:(id)key;
+(id)getObjectFromKeychainForKey:(id)key;
+(void)logout;

@end
