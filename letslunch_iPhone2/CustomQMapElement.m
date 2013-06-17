//
//  CustomQMapElement.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 17/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "CustomQMapElement.h"

@implementation CustomQMapElement

- (QMapElement *)init {
    self = [super init];
    return self;
}

- (QMapElement *)initWithTitle:(NSString *)title coordinate:(CLLocationCoordinate2D)coordinate {
    self = [super initWithTitle:title coordinate:coordinate];
    return self;
}

@end
