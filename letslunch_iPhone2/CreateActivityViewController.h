//
//  CreateActivityViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

@interface CreateActivityViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *textFieldDescription;
@property (retain, nonatomic) IBOutlet UISegmentedControl *segment;
@property (retain, nonatomic) IBOutlet UIButton *buttonPushPlace;
@property (retain, nonatomic) IBOutlet UILabel *labelBroadcast;

+(CreateActivityViewController*)getSingleton;
-(void)pushSelectPlace:(id)sender;
-(IBAction)segmentValueChanged:(id)sender;

@end
