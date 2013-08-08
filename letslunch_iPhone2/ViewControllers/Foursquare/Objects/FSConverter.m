//
//  FSConverter.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 20/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "FSConverter.h"
#import "FSVenue.h"

@implementation FSConverter

- (NSMutableArray*)convertToObjects:(NSArray*)venues{
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:[venues count]];
    if([venues count] < 2)
        venues = venues[0];
    
    for (NSDictionary *v  in venues) {
        NSMutableDictionary *location = [[NSMutableDictionary alloc] init];
        [location setValue:v[@"location"][@"address"] forKey:@"venueAddress"];
        [location setValue:v[@"location"][@"distance"] forKey:@"venueDistance"];
        [location setValue:v[@"location"][@"lat"] forKey:@"degreesLatitude"];
        [location setValue:v[@"location"][@"lng"] forKey:@"degreesLongitude"];
        
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setValue:v[@"name"] forKey:@"venueName"];
        [dictionary setValue:v[@"id"] forKey:@"venueId"];
        [dictionary setValue:location forKey:@"location"];
        
        FSVenue *venue = [[FSVenue alloc] initWithDictionary:dictionary];
        [objects addObject:venue];
    }
    
    NSArray *sorted = [objects sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSNumber *first = [(FSVenue*)a distance];
        NSNumber *second = [(FSVenue*)b distance];
        return [first compare:second];
    }];
    return (NSMutableArray*)sorted;
}

@end
