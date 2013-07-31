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

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CenterViewController *viewController;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) Activity *ownerActivity;
@property (strong, nonatomic) Contacts *ownerContact;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) TwitterConsumer* consumer;
@property (strong, nonatomic) TwitterToken* token;

-(NSMutableArray*)getListActivitiesAndForceReload:(BOOL)shouldReload;
-(NSMutableArray*)getListFriendsSuggestionAndForceReload:(BOOL)shouldReload;
-(NSMutableArray*)getListVisitorsAndForceReload:(BOOL)shouldReload;
-(NSMutableArray*)getListMessagesForContactID:(NSString*)contactID andForceReload:(BOOL)shouldReload;
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
