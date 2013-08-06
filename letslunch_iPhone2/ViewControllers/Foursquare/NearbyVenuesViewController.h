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
@interface NearbyVenuesViewController :UIViewController<CLLocationManagerDelegate, UITextFieldDelegate> {
    CLLocationManager *_locationManager;
}

@property (nonatomic, strong) IBOutlet UITableView* tableView;

@property (nonatomic, strong) FSVenue *selected;
@property (nonatomic, strong) NSMutableArray *nearbyVenues;

@property (nonatomic, strong) NSString *section;
@property (nonatomic, strong) NSString *query;
@property (nonatomic, strong) NSNumber *radius;
@property (nonatomic) BOOL isSearching;

@property (nonatomic, strong) UITextField *textFieldSearch;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segment;

-(IBAction)valueChanged:(id)sender;
-(void)search:(id)sender;
@end
