//
//  AppDelegate.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CenterViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "LoginViewController.h"
#import "OAuthConsumer.h"
#import "OAuthLoginView.h"
#import "Activity.h"
#import "KeychainWrapper.h"

@class TwitterConsumer;
@class TwitterToken;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    KeychainWrapper *tokenItem;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CenterViewController *viewController;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) LoginViewController *loginViewController;
@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;

@property (strong, nonatomic) NSMutableArray *listActivities;
@property (strong, nonatomic) NSMutableArray *listFriendsSuggestion;
@property (strong, nonatomic) NSMutableArray *listMessages;
@property (strong, nonatomic) NSMutableArray *listContacts;
@property (strong, nonatomic) NSMutableArray *listVisitors;
@property (strong, nonatomic) Activity *ownerActivity;

@property (strong, nonatomic) TwitterConsumer* consumer;
@property (strong, nonatomic) TwitterToken* token;
@property (nonatomic, retain) KeychainWrapper *tokenItem;

-(NSMutableArray*)getListActivitiesAndForceReload:(BOOL)shouldReload;
-(NSMutableArray*)getListFriendsSuggestionAndForceReload:(BOOL)shouldReload;
-(NSMutableArray*)getListVisitorsAndForceReload:(BOOL)shouldReload;
-(NSMutableArray*)getListMessagesForContactID:(NSString*)contactID andForceReload:(BOOL)shouldReload;
-(NSMutableArray*)getListContactsAndForceReload:(BOOL)shouldReload;
-(Activity*)getOwnerActivityAndForceReload:(BOOL)shouldReload;

-(void)loginSuccessfull;
-(void)hideLoginView;

-(void)openSession;
-(void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;

-(void)writeObjectToKeychain:(id)object forKey:(id)key;
-(id)getObjectFromKeychainForKey:(id)key;
-(void)logout;

+(UIColor*)colorWithHexString:(NSString*)hex;
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
+(void)writeObjectToKeychain:(id)object forKey:(id)key;
+(id)getObjectFromKeychainForKey:(id)key;
+(void)logout;

@end
