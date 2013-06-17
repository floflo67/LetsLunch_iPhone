//
//  CustomQMapElement.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 17/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "quickdialog/QMapElement.h"
#import "quickdialog/QMapViewController.h"

@interface CustomQMapElement : QMapElement
- (QMapElement *)initWithTitle:(NSString *)string coordinate:(CLLocationCoordinate2D)param;

@end
