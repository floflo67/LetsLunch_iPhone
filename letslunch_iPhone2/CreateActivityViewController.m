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
    if (sharedSingleton != nil)
        return sharedSingleton;
    @synchronized(self)
    {
        if (sharedSingleton == nil)
            sharedSingleton = [[self alloc] init];
    }
    return sharedSingleton;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Create";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                              target:self
                                              action:@selector(saveActivity:)];
    
    /*
     Change font and size of segmentControl's titles
     */
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
        self.labelBroadcast.text = @"This broadcast will expire at 11:00 P.M.";        
}

- (void)saveActivity:(id)sender
{
    NSLog(@"Description: %@", self.textFieldDescription.text);
    
    NSString *type;
    if(self.segment.selectedSegmentIndex == 0)
        type = @"Coffee";
    else if (self.segment.selectedSegmentIndex == 1)
        type = @"Lunch";
    else
        type = @"Coffee";
    
    NSLog(@"Type: %@", type);
    NSLog(@"Place: %@", [self.venue name]);
    NSLog(@"Save");
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)textFieldReturn:(id)sender
{
    [self textFieldShouldReturn:sender];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

- (void)dealloc {
    [_textFieldDescription release];
    [_segment release];
    [_buttonPushPlace release];
    [_labelBroadcast release];
    [super dealloc];
}
@end
