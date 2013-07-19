//
//  NearbyVenuesViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 20/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@class FSVenue;
@interface NearbyVenuesViewController :UIViewController<CLLocationManagerDelegate, UITextFieldDelegate>{
    CLLocationManager *_locationManager;
}

@property (strong, nonatomic) IBOutlet UITableView* tableView;

@property (strong, nonatomic) FSVenue *selected;
@property (strong, nonatomic) NSMutableArray *nearbyVenues;

@property (strong, nonatomic) NSString *section;
@property (strong, nonatomic) NSString *query;
@property (strong, nonatomic) NSNumber *radius;
@property (nonatomic) BOOL isSearching;

@property (strong, nonatomic) UITextField *textFieldSearch;
@property (retain, nonatomic) IBOutlet UISegmentedControl *segment;

-(IBAction)valueChanged:(id)sender;
-(void)search:(id)sender;
@end
