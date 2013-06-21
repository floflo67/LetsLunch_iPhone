//
//  CreateActivityViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "CreateActivityViewController.h"
#import "AppDelegate.h"
#import "NearbyVenuesViewController.h"

@interface CreateActivityViewController ()

@end

@implementation CreateActivityViewController

static CreateActivityViewController *sharedSingleton = nil;
+ (CreateActivityViewController*)getSingleton
{
    if (sharedSingleton !=nil)
    {
        NSLog(@"CreateActivityViewController has already been created.....");
        return sharedSingleton;
    }
    @synchronized(self)
    {
        if (sharedSingleton == nil)
        {
            sharedSingleton = [[self alloc] init];
            NSLog(@"Created a new CreateActivityViewController");
        }
    }
    return sharedSingleton;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Create";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                              target:((AppDelegate*)[UIApplication sharedApplication].delegate).viewController
                                              action:@selector(saveActivity:)];
    [self.buttonPushPlace addTarget:self action:@selector(pushSelectPlace:) forControlEvents:UIControlEventTouchDown];
    
    UIFont *font = [UIFont boldSystemFontOfSize:16.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:UITextAttributeFont];
    [self.segment setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)pushSelectPlace:(id)sender
{
    [self.navigationController pushViewController:[[NearbyVenuesViewController alloc] init] animated:YES];
}

- (IBAction)segmentValueChanged:(id)sender
{
    UISegmentedControl *seg = (UISegmentedControl*)sender;
    
    if(seg.selectedSegmentIndex == 0)
        self.labelBroadcast.text = @"This broadcast will expire in 180 minutes.";
    else
        self.labelBroadcast.text = @"This broadcast will expire at 11 p.m.";        
}

- (void)dealloc {
    [_textFieldDescription release];
    [_segment release];
    [_buttonPushPlace release];
    [_labelBroadcast release];
    [super dealloc];
}
@end
