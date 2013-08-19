//
//  AppDelegate.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "CenterViewController.h"
#import "GetStaticLists.h"
#import "ActivityViewController.h"
#import "ContactViewController.h"
#import "ProfileViewController.h"
#import "VisitorsViewController.h"
#import "ProfileRequest.h"
#import <FacebookSDK/FacebookSDK.h>
#import "SocialConnectionRequest.h"
#import "InviteViewController.h"

@interface AppDelegate()
@property (nonatomic, strong) NSMutableArray *listActivities;
@property (nonatomic, strong) NSMutableArray *listFriendsSuggestion;
@property (nonatomic, strong) NSMutableArray *listMessages;
@property (nonatomic, strong) NSMutableArray *listContacts;
@property (nonatomic, strong) NSMutableArray *listVisitors;
@property (nonatomic, strong) LoginViewController *loginViewController;
@property (nonatomic, strong) KeychainWrapper *tokenItem;
@property (nonatomic) BOOL alertIsShown;
@property (nonatomic) BOOL hasEnableGPS;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    /*if(![[self getObjectFromKeychainForKey:kSecAttrAccount] isEqualToString:@"token"])
     [self.tokenItem resetKeychainItem];*/
    
    /*
     Sets window
     */
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    
    /*
     Sets navigation controller
     */
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
        
    if([[self getToken] isEqualToString:@"token"])
        [self showLoginView];
    else
        [self loginSuccessfull];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication*)application
{
    [[FBSession activeSession] handleDidBecomeActive];
}

/*
- (void)applicationDidEnterBackground:(UIApplication*)application
{
    [self.navController popToRootViewControllerAnimated:YES];
    [self suppressDataOnLogout];
}

- (void)applicationWillEnterForeground:(UIApplication*)application
{
    [self loginSuccessfull];
}*/

#pragma mark - login

- (void)loginSuccessfull
{
    /*
     To get current location
     */
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    
    //[SocialConnectionRequest getSocialConnectionWithToken:[self getToken]];
    [self hideLoginView];
    [self.viewController ActivityConfiguration];
}

- (void)showLoginView
{
    [self.loginViewController.view setFrame:[[UIScreen mainScreen] bounds]];
    [self.viewController.navigationController.view addSubview:self.loginViewController.view];
}

- (void)hideLoginView
{
    [self.loginViewController.view removeFromSuperview];
    [self.loginViewController.view setHidden:YES];
    self.loginViewController = nil;
}

#pragma mark - custom functions

+ (UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - keychain

+ (NSString*)getToken
{
    return [[AppDelegate getAppDelegate] getToken];
}

- (NSString*)getToken
{
    return [self getObjectFromKeychainForKey:(__bridge id)kSecAttrAccount];
}

+ (void)writeObjectToKeychain:(id)object forKey:(id)key
{
    [[AppDelegate getAppDelegate] writeObjectToKeychain:object forKey:key];
}

- (void)writeObjectToKeychain:(id)object forKey:(id)key
{
    [self.tokenItem mySetObject:object forKey:key];
}

+ (id)getObjectFromKeychainForKey:(id)key
{
    return [[AppDelegate getAppDelegate] getObjectFromKeychainForKey:key];
}

- (id)getObjectFromKeychainForKey:(id)key
{
    return [self.tokenItem myObjectForKey:key];
}

+ (void)logout
{
    [[AppDelegate getAppDelegate] logout];
}

- (void)logout
{
    [ProfileRequest logoutWithToken:[AppDelegate getToken]];
    [self.tokenItem resetKeychainItem];
    [self suppressDataOnLogout];
    [self showLoginView];
}

- (void)suppressDataOnLogout
{
    [ActivityViewController suppressSingleton];
    [ContactViewController suppressSingleton];
    [ProfileViewController suppressSingleton];
    [VisitorsViewController suppressSingleton];
    [InviteViewController suppressSingleton];
    
    self.ownerActivity = nil;
    self.ownerContact = nil;
    self.listActivities = nil;
    self.listContacts = nil;
    self.listFriendsSuggestion = nil;
    self.listMessages = nil;
    self.listVisitors = nil;
    self.locationManager = nil;
}

#pragma mark - lists

- (NSMutableArray*)getListActivitiesAndForceReload:(BOOL)shouldReload
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [format stringFromDate:[NSDate new]];
    
    if(shouldReload)
        self.listActivities = [GetStaticLists getListActivitiesWithToken:[AppDelegate getToken] latitude:self.locationManager.location.coordinate.latitude longitude:self.locationManager.location.coordinate.longitude andDate:date];
    
    return self.listActivities;
}

- (NSMutableArray*)getListFriendsSuggestionAndForceReload:(BOOL)shouldReload
{
    if(shouldReload)
        self.listFriendsSuggestion = [GetStaticLists getListFriendsSuggestion];
    return self.listFriendsSuggestion;
}

- (NSMutableArray*)getListVisitorsAndForceReload:(BOOL)shouldReload
{
    if(shouldReload)
        self.listVisitors = [GetStaticLists getListVisitors];
    return self.listVisitors;
}

- (NSMutableArray*)getListMessagesForThreadID:(NSString*)threadID
{
    self.listMessages = [GetStaticLists getListMessagesForThreadID:threadID];
    return self.listMessages;
}

- (NSMutableArray*)getListContactsAndForceReload:(BOOL)shouldReload
{
    if(shouldReload)
        self.listContacts = [GetStaticLists getListContacts];
    return self.listContacts;
}

- (Activity*)getOwnerActivityAndForceReload:(BOOL)shouldReload
{
    if(shouldReload)
        self.ownerActivity = [GetStaticLists getOwnerActivityWithToken:[self getToken]];
    return self.ownerActivity;
}

#pragma mark - Error message

+(void)showNoConnectionMessage
{
    [AppDelegate showErrorMessage:@"No connection." withTitle:@"500"];
}

+ (void)showErrorMessage:(NSString*)message withTitle:(NSString*)errorTitle;
{
    [[AppDelegate getAppDelegate] showErrorMessage:message withTitle:errorTitle];
}

- (void)showErrorMessage:(NSString*)message withTitle:(NSString*)errorTitle;
{
    if(!self.alertIsShown) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NULL message:NULL delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.title = [NSString stringWithFormat:@"App error: %@", errorTitle];
        alert.message = message;
        [alert show];
        alert = nil;
        self.alertIsShown = YES;
    }
}

- (void)alertView:(UIAlertView*)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    self.alertIsShown = NO;
}

#pragma mark - getter and setter

+ (AppDelegate*)getAppDelegate
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

- (CenterViewController*)viewController
{
    if(!_viewController)
        _viewController = [[CenterViewController alloc] init];
    return _viewController;
}

- (UINavigationController*)navController
{
    if(!_navController) {
        _navController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
        [_navController.navigationBar setTintColor:[UIColor orangeColor]];
    }
    return _navController;
}

- (KeychainWrapper*)tokenItem
{
    if(!_tokenItem)
        _tokenItem = [[KeychainWrapper alloc] initWithIdentifier:@"LetsLunchToken" accessGroup:nil];
    return _tokenItem;
}

- (CLLocationManager*)locationManager
{
    if(!_locationManager)
        _locationManager = [[CLLocationManager alloc] init];
    return _locationManager;
}

- (LoginViewController*)loginViewController
{
    if(!_loginViewController)
        _loginViewController = [[LoginViewController alloc] init];
    return _loginViewController;
}

- (Activity*)ownerActivity
{
    if(!_ownerActivity)
        _ownerActivity = [GetStaticLists getOwnerActivityWithToken:[self getToken]];
    return _ownerActivity;
}

- (NSMutableArray*)listActivities
{
    if(!_listActivities) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];
        NSString *date = [format stringFromDate:[NSDate new]];
        
        _listActivities = [[NSMutableArray alloc] initWithArray:[GetStaticLists getListActivitiesWithToken:[AppDelegate getToken] latitude:self.locationManager.location.coordinate.latitude longitude:self.locationManager.location.coordinate.longitude andDate:date]];
    }
    return _listActivities;
}

- (NSMutableArray*)listContacts
{
    if(!_listContacts)
        _listContacts = [[NSMutableArray alloc] initWithArray:[GetStaticLists getListContacts]];
    return _listContacts;    
}

- (NSMutableArray*)listFriendsSuggestion
{
    if(!_listFriendsSuggestion)
        _listFriendsSuggestion = [[NSMutableArray alloc] initWithArray:[GetStaticLists getListFriendsSuggestion]];
    return _listFriendsSuggestion;
}

- (NSMutableArray*)listVisitors
{
    if(!_listVisitors)
        _listVisitors = [[NSMutableArray alloc] initWithArray:[GetStaticLists getListVisitors]];
    return _listVisitors;
}

- (NSMutableArray*)listMessages
{
    if(!_listMessages)
        _listMessages = [[NSMutableArray alloc] init];
    return _listMessages;
}

- (Contacts*)ownerContact
{
    if(!_ownerContact)
        _ownerContact = [[Contacts alloc] initWithDictionary:[ProfileRequest getProfileWithToken:[self getToken] andLight:YES]];
    return _ownerContact;
}

- (BOOL)hasEnableGPS
{
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)
        _hasEnableGPS = YES;
    else
        _hasEnableGPS = NO;
    return _hasEnableGPS;
}

@end
