//
//  ActivityViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LunchesRequest.h"

@interface ActivityViewController : UITableViewController <LunchRequestDelegate> {
    LunchesRequest *lunchRequest;
}

@property (nonatomic, strong) NSMutableArray* objects;
@property (nonatomic) BOOL hasActivity;
@property (nonatomic, retain) LunchesRequest *lunchRequest;

-(void)loadOwnerActivity;

+(ActivityViewController*)getSingleton;

@end
