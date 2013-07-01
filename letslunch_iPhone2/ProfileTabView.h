//
//  ProfileTabView.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAuthLoginView.h"
#import "JSONKit.h"
#import "OAConsumer.h"
#import "OAMutableURLRequest.h"
#import "OADataFetcher.h"
#import "OATokenManager.h"

@interface ProfileTabView : UIViewController 
{
}

@property (nonatomic, retain) IBOutlet UIButton *button;
@property (nonatomic, retain) IBOutlet UIButton *postButton;
@property (nonatomic, retain) IBOutlet UILabel *postButtonLabel;
@property (nonatomic, retain) IBOutlet UILabel *name;
@property (nonatomic, retain) IBOutlet UILabel *headline;
@property (nonatomic, retain) IBOutlet UILabel *status;
@property (nonatomic, retain) IBOutlet UILabel *updateStatusLabel;
@property (nonatomic, retain) IBOutlet UITextField *statusTextView;
@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;


- (IBAction)button_TouchUp:(UIButton *)sender;
- (void)profileApiCall;
- (void)networkApiCall;


@end
