//
//  FSVenue.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 20/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "FSVenue.h"


@implementation FSLocation

- (void)dealloc
{
    [self.distance release];
    [self.address release];
    [super dealloc];
}

@end

@implementation FSVenue

- (id)init
{
    self = [super init];
    if (self) {
        self.location = [[FSLocation alloc]init];
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

- (void)dealloc
{
    [self.name release];
    [self.venueId release];
    [self.location release];
    [self.distance release];
    [self.categoryName release];
    [super dealloc];
}

@end
