//
//  ShareViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 27/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "ShareViewController.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <FacebookSDK/FacebookSDK.h>
#import "FacebookShare.h"

@interface ShareViewController ()
@property (nonatomic, strong) SLComposeViewController *mySLComposerSheet;
@property (nonatomic, weak) IBOutlet UIButton *facebookButton;
@property (nonatomic, weak) IBOutlet UIButton *twitterButton;
@property (nonatomic) BOOL mustShareOnFacebook;
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

#pragma mark - Social sharing

- (void)shareOnFacebook
{
    __weak typeof(self) weakSelf = self;
    
    self.mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook]; //Tell him with what social plattform to use it, e.g. facebook or twitter
    [self.mySLComposerSheet setInitialText:@"Test Facebook"/*[NSString stringWithFormat:@"Test", self.mySLComposerSheet.serviceType]*/]; //the message you want to post
    //for more instance methodes, go here:https://developer.apple.com/library/ios/#documentation/NetworkingInternet/Reference/SLComposeViewController_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40012205
    [self presentViewController:self.mySLComposerSheet animated:YES completion:nil];
    
    
    [self.mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        BOOL success = NO;
        NSString *output;
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Action Cancelled";
                break;
            case SLComposeViewControllerResultDone:
                output = @"Post Successfull";
                success = YES;
                break;
            default:
                break;
        }
        
        if(success) {
            weakSelf.facebookButton.alpha = 0.4;
            weakSelf.facebookButton.enabled = NO;
        }
        
        if(weakSelf.mySLComposerSheet) {
            [weakSelf.mySLComposerSheet dismissViewControllerAnimated:YES completion:nil];
            weakSelf.mySLComposerSheet = nil;
        }
    }];
    
    /*
    FacebookShare *facebookShare = [[FacebookShare alloc] init];
    [facebookShare postToFacebook:@"Let's Lunch - iPhone" productLink:@"www.letslunch.com" productImageUrl:@"http://farm6.static.flickr.com/5065/5681696034_e9f67e2181.jpg"];
    self.facebookButton.enabled = NO;
    self.facebookButton.alpha = 0.3;*/
}

- (void)shareOnTwitter
{
    __weak typeof(self) weakSelf = self;
    
    self.mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter]; //Tell him with what social plattform to use it, e.g. facebook or twitter
    [self.mySLComposerSheet setInitialText:@"Test Twitter"/*[NSString stringWithFormat:@"Test", self.mySLComposerSheet.serviceType]*/]; //the message you want to post
    //for more instance methodes, go here:https://developer.apple.com/library/ios/#documentation/NetworkingInternet/Reference/SLComposeViewController_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40012205
    [self presentViewController:self.mySLComposerSheet animated:YES completion:nil];
    
    
    [self.mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        BOOL success = NO;
        NSString *output;
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Action Cancelled";
                break;
            case SLComposeViewControllerResultDone:
                output = @"Post Successfull";
                success = YES;
                break;
            default:
                break;
        }
        
        if(success) {
            weakSelf.twitterButton.alpha = 0.4;
            weakSelf.twitterButton.enabled = NO;
        }
        
        if(weakSelf.mySLComposerSheet) {
            [weakSelf.mySLComposerSheet dismissViewControllerAnimated:YES completion:nil];
            weakSelf.mySLComposerSheet = nil;
        }
    }];
}


#pragma mark - Button events

- (IBAction)facebookButton:(UIButton*)sender
{
    if(!self.facebookButton.selected)
        [self shareOnFacebook];
}

- (IBAction)twitterButton:(UIButton*)sender
{
    if(!self.twitterButton.selected)
        [self shareOnTwitter];
}

- (IBAction)closeButton:(id)sender
{
    [((AppDelegate*)[[UIApplication sharedApplication] delegate]).viewController closeView];
}

- (IBAction)promoteButton:(UIButton*)sender
{
    if(self.mustShareOnFacebook)
        [self shareOnFacebook];
}

#pragma mark - getter and setter

- (SLComposeViewController*)mySLComposerSheet
{
    if(!_mySLComposerSheet)
        _mySLComposerSheet = [[SLComposeViewController alloc] init];
    return _mySLComposerSheet;
}

@end
