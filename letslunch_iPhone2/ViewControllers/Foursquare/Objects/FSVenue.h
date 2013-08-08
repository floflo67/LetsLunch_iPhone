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

@property (nonatomic, assign, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong, readonly) NSNumber *distance;
@property (nonatomic, strong, readonly) NSString *address;

-(id)initWithDictionary:(NSDictionary*)dict;

@end

@interface FSVenue : NSObject<MKAnnotation>

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *venueId;
@property (nonatomic, strong, readonly) FSLocation *location;
@property (nonatomic, weak, readonly) NSNumber *distance;

-(id)initWithDictionary:(NSDictionary*)dict;

@end
