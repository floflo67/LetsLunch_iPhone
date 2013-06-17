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
    
#if EXPERIEMENTAL_ORIENTATION_SUPPORT
    UINavigationController *container = [[UINavigationController alloc] init];
    [container setNavigationBarHidden:YES animated:NO];
    [container setViewControllers:[NSArray arrayWithObject:navController] animated:NO];
    self.window.rootViewController = container;
#else
    self.window.rootViewController = navController;
#endif
    
    [self.window makeKeyAndVisible];
    _viewController = controller;
    return YES;
}

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

- (NSMutableArray*) getListMessages
{
    if(!self.listMessages) {
        self.listMessages = [[[NSMutableArray alloc] init] autorelease];
        self.listMessages = [GetStaticLists getListMessages];
    }
    
    return self.listMessages;
}

- (NSString*) getOwnerActivity
{
    if(!self.ownerActivity) {
        self.ownerActivity = [GetStaticLists getOwnerActivity];
    }
    return NULL;
    //return self.ownerActivity;
}

#pragma application lifecycle

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [self.listActivities release];
    [self.listFriendsSuggestion release];
    [self.listMessages release];
    [_window release];
    [_viewController release];
    [super dealloc];
}

@end
