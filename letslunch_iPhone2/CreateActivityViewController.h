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

@property (retain, nonatomic) FSVenue *venue;
@property (retain, nonatomic) Activity *activity;
@property (retain, nonatomic) MKMapView *map;
@property (retain, nonatomic) LunchesRequest *lunchRequest;

@property (retain, nonatomic) IBOutlet UITextField *textFieldDescription;
@property (retain, nonatomic) IBOutlet UISegmentedControl *segment;
@property (retain, nonatomic) IBOutlet UILabel *labelBroadcast;
@property (retain, nonatomic) IBOutlet UIView *viewContent;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIView *viewSubview;
@property (strong, nonatomic) UIButton *buttonClear;

+(CreateActivityViewController*)getSingleton;
-(IBAction)segmentValueChanged:(id)sender;
-(IBAction)textFieldReturn:(id)sender;

-(void)loadViewWithActivity:(Activity*)activity;

-(void)addMap:(FSVenue*)venue;

@end
