//
//  FSVenue.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 20/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "FSVenue.h"

@interface FSLocation ()

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSNumber *distance;
@property (nonatomic, strong) NSString *address;

@end

@implementation FSLocation

- (id)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        [self setCoordinate:CLLocationCoordinate2DMake([[dict objectForKey:@"degreesLatitude"] doubleValue], [[dict objectForKey:@"degreesLongitude"] doubleValue])];
        self.address = [dict objectForKey:@"venueAddress"];
        self.distance = [dict objectForKey:@"venueDistance"];
    }
    return self;
}

@end

@interface FSVenue()

@property (nonatomic, strong) FSLocation *location;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *venueId;
@property (nonatomic, weak) NSNumber *distance;
@property (nonatomic, strong) NSString *categoryName;

@end

@implementation FSVenue

- (id)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        self.location = [[FSLocation alloc] initWithDictionary:[dict objectForKey:@"location"]];
        self.name = [dict objectForKey:@"venueName"];
        self.venueId = [dict objectForKey:@"venueId"];
        self.distance = self.location.distance;
    }
    return self;
}

- (CLLocationCoordinate2D)coordinate
{
    return self.location.coordinate;
}

- (NSString*)title
{
    return self.name;
}

#pragma mark - getter and setter

- (FSLocation *)location
{
    if(!_location)
        _location = [[FSLocation alloc] init];
    return _location;
}

@end
