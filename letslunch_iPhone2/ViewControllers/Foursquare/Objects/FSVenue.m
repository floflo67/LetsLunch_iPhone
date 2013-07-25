//
//  FSVenue.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 20/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "FSVenue.h"

@implementation FSLocation

- (id)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        [self setCoordinate:CLLocationCoordinate2DMake([[dict objectForKey:@"degreesLatitude"] doubleValue], [[dict objectForKey:@"degreesLongitude"] doubleValue])];
        self.address = [dict objectForKey:@"venueAddress"];
    }
    return self;
}

@end

@implementation FSVenue

- (id)init
{
    self = [super init];
    if (self) {
        self.location = [[FSLocation alloc] init];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        self.location = [[FSLocation alloc] initWithDictionary:[dict objectForKey:@"location"]];
        self.name = [dict objectForKey:@"venueName"];
        self.venueId = [dict objectForKey:@"venueId"];
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

@end
