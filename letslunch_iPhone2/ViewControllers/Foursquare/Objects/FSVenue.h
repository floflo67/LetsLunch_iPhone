//
//  FSVenue.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 20/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface FSLocation : NSObject
{
    CLLocationCoordinate2D _coordinate;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSNumber *distance;
@property (nonatomic, strong) NSString *address;

@end


@interface FSVenue : NSObject<MKAnnotation>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *venueId;
@property (nonatomic, strong) FSLocation *location;
@property (nonatomic, assign) NSNumber *distance;
@property (nonatomic, strong) NSString *categoryName;

@end
