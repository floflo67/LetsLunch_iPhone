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

@interface ShareViewController ()
@property (nonatomic, strong) SLComposeViewController *mySLComposerSheet;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (nonatomic) BOOL shareFacebook;
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
    [self.mySLComposerSheet setInitialText:@"Test"/*[NSString stringWithFormat:@"Test", self.mySLComposerSheet.serviceType]*/]; //the message you want to post
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
        
        //check if everythink worked properly. Give out a message on the state.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
        if(success) {
            weakSelf.facebookButton.alpha = 0.4;
            weakSelf.facebookButton.enabled = NO;
        }
    }];
}

#pragma mark - Button events

- (IBAction)facebookButton:(UIButton*)sender
{
    if(!self.facebookButton.selected)
        [self shareOnFacebook];
    
    self.facebookButton.selected = !self.facebookButton.selected;
}

- (IBAction)closeButton:(id)sender
{
    if(self.shareFacebook)
       [self shareOnFacebook];
    
    [((AppDelegate*)[[UIApplication sharedApplication] delegate]).viewController closeView];
}

#pragma mark - getter and setter

- (SLComposeViewController*)mySLComposerSheet
{
    if(!_mySLComposerSheet)
        _mySLComposerSheet = [[SLComposeViewController alloc] init];
    return _mySLComposerSheet;
}

@end
