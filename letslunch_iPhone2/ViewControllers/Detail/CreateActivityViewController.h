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
@property (strong, nonatomic) Activity *activity;
@property (strong, nonatomic) MKMapView *map;
@property (strong, nonatomic) LunchesRequest *lunchRequest;

@property (strong, nonatomic) IBOutlet UITextField *textFieldDescription;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;
@property (strong, nonatomic) IBOutlet UILabel *labelBroadcast;
@property (strong, nonatomic) IBOutlet UIView *viewContent;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *viewSubview;
@property (strong, nonatomic) UIButton *buttonClear;

+(CreateActivityViewController*)getSingleton;
-(IBAction)segmentValueChanged:(id)sender;
-(IBAction)textFieldReturn:(id)sender;

-(void)loadViewWithActivity:(Activity*)activity;

-(void)addMap:(FSVenue*)venue;

@end
