//
//  CreateActivityViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "Activity.h"
#import "LunchesRequest.h"

@interface CreateActivityViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) FSVenue *venue;

+(CreateActivityViewController*)getSingleton;
-(void)loadViewWithActivity:(Activity*)activity;
-(void)addMap:(FSVenue*)venue;

@end
