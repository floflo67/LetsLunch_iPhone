//
//  CreateActivityViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "FSVenue.h"
#import "Activity.h"
#import "LunchesRequest.h"

@class LunchesRequest;

@interface CreateActivityViewController : UIViewController <UITextFieldDelegate, LunchRequestDelegate> {
    LunchesRequest *_lunchRequest;
}

@property (strong, nonatomic) FSVenue *venue;

+(CreateActivityViewController*)getSingleton;
-(void)loadViewWithActivity:(Activity*)activity;
-(void)addMap:(FSVenue*)venue;

@end
