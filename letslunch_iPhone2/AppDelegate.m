//
//  AppDelegate.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "AppDelegate.h"
#import "CenterViewController.h"
#import "GetStaticLists.h"
#import "LoginViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    CenterViewController *controller = [[CenterViewController alloc] init];
    controller.title = @"ViewController";
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [navController.navigationBar setTintColor:[UIColor orangeColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    _viewController = controller;
    
    BOOL login = NO;
    if(!login)
        [self loadLoginView];
    
    return YES;
}

- (void)loadLoginView
{
    LoginViewController *login = [[LoginViewController alloc] init];
    [login.view setFrame:[[UIScreen mainScreen] bounds]];
    [self.viewController.navigationController.view addSubview:login.view];
}

#pragma custom functions

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

#pragma lists

- (NSMutableArray*)getListActivities
{
    if(!self.listActivities) {
        self.listActivities = [[[NSMutableArray alloc] init] autorelease];
        self.listActivities = [GetStaticLists getListActivities];
    }
    
    return self.listActivities;
}

- (NSMutableArray*) getListFriendsSuggestion
{
    if(!self.listFriendsSuggestion) {
        self.listFriendsSuggestion = [[[NSMutableArray alloc] init] autorelease];
        self.listFriendsSuggestion = [GetStaticLists getListFriendsSuggestion];
    }
    
    return self.listFriendsSuggestion;
}

- (NSMutableArray*) getListMessagesForContactID:(NSString*)contactID
{
    if(!self.listMessages) {
        self.listMessages = [[[NSMutableArray alloc] init] autorelease];
        self.listMessages = [GetStaticLists getListMessagesForContactID:contactID];
    }
    
    return self.listMessages;
}

- (NSMutableArray*)getListContacts
{
    if(!self.listContacts) {
        self.listContacts = [[[NSMutableArray alloc] init] autorelease];
        self.listContacts = [GetStaticLists getListContacts];
    }
    return self.listContacts;
}

- (NSString*) getOwnerActivity
{
    if(!self.ownerActivity) {
        self.ownerActivity = [GetStaticLists getOwnerActivity];
    }
    return NULL;
    //return self.ownerActivity;
}

- (void)dealloc
{
    self.listActivities = nil;
    self.listFriendsSuggestion = nil;
    self.listMessages = nil;
    _window = nil;
    _viewController = nil;
    [super dealloc];
}

@end
