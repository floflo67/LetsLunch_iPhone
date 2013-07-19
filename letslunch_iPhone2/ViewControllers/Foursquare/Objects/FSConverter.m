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
        FSVenue *ann = [[FSVenue alloc]init];
        
        ann.name = v[@"name"];
        ann.venueId = v[@"id"];
        //ann.categoryName = str;
        ann.location.address = v[@"location"][@"address"];
        ann.location.distance = v[@"location"][@"distance"];
        ann.distance = ann.location.distance;
        
        [ann.location setCoordinate:CLLocationCoordinate2DMake([v[@"location"][@"lat"] doubleValue], [v[@"location"][@"lng"] doubleValue])];
        [objects addObject:ann];
    }
    
    NSArray *sorted = [objects sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSNumber *first = [(FSVenue*)a distance];
        NSNumber *second = [(FSVenue*)b distance];
        return [first compare:second];
    }];
    return (NSMutableArray*)sorted;
}

@end
