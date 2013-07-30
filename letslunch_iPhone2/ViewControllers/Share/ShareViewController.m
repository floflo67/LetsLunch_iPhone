//
//  ShareViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 27/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonClose;
@end

@implementation ShareViewController


static ShareViewController *sharedSingleton = nil;
+ (ShareViewController*)getSingleton
{
    if (sharedSingleton != nil)
        return sharedSingleton;
    @synchronized(self)
    {
        if (sharedSingleton == nil)
            sharedSingleton = [[self alloc] init];
    }
    return sharedSingleton;
}

+ (void)suppressSingleton
{
    if (sharedSingleton != nil)
        sharedSingleton = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.buttonClose addTarget:((AppDelegate*)[[UIApplication sharedApplication] delegate]).viewController
                         action:@selector(closeView:)
               forControlEvents:UIControlEventTouchDown];
}

@end
