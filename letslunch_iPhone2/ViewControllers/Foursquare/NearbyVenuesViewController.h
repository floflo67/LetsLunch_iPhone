//
//  NearbyVenuesViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 20/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@class FSVenue;
@interface NearbyVenuesViewController :UIViewController<CLLocationManagerDelegate, UITextFieldDelegate>

-(IBAction)valueChanged:(id)sender;
-(void)search:(id)sender;
@end
