//
//  DetailProfileViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 22/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileDetailsRequest.h"

@interface DetailProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    ProfileDetailsRequest *profileDetailRequest;
}

@property (nonatomic, strong) NSMutableDictionary* objects;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ProfileDetailsRequest *profileDetailRequest;

-(id)initWithContactID:(NSString*)contactID;

@end
