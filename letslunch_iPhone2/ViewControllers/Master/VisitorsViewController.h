//
//  VisitorsViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 19/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisitorsRequest.h"

@interface VisitorsViewController : UITableViewController {
    VisitorsRequest *_visitorRequest;
}

@property (nonatomic, strong) NSMutableArray* objects;
@property (nonatomic, strong) VisitorsRequest *visitorRequest;

+(VisitorsViewController*)getSingleton;

@end
