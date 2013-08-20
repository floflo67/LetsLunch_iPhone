//
//  AppDelegate.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "CenterViewController.h"
#import "Activity.h"
#import "Contacts.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong, readonly) CenterViewController *viewController;
@property (nonatomic, strong, readonly) UINavigationController *navController;

@property (nonatomic, strong, readonly) Activity *ownerActivity;
@property (nonatomic, strong, readonly) Contacts *ownerContact;

@property (nonatomic, strong, readonly) CLLocationManager *locationManager;
@property (nonatomic, readonly) BOOL hasEnableGPS;

@property (nonatomic, strong, readonly) NSString *linkedinToken;

-(NSMutableArray*)getListActivitiesAndForceReload:(BOOL)shouldReload;
-(NSMutableArray*)getListFriendsSuggestionAndForceReload:(BOOL)shouldReload;
-(NSMutableArray*)getListVisitorsAndForceReload:(BOOL)shouldReload;
-(NSMutableArray*)getListMessagesForThreadID:(NSString*)threadID;
-(NSMutableArray*)getListContactsAndForceReload:(BOOL)shouldReload;
-(Activity*)getOwnerActivityAndForceReload:(BOOL)shouldReload;

+(void)showErrorMessage:(NSString*)message withTitle:(NSString*)errorTitle;
+(void)showNoConnectionMessage;

-(void)loginSuccessfull;

+(AppDelegate*)getAppDelegate;

+(NSString*)getToken;
+(UIColor*)colorWithHexString:(NSString*)hex;
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
+(void)writeObjectToKeychain:(id)object forKey:(id)key;
+(id)getObjectFromKeychainForKey:(id)key;
+(void)logout;

-(void)setOwnerActivity:(Activity *)ownerActivity;
-(void)setLinkedinToken:(NSString*)linkedinToken;

@end
