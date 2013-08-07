//
//  DetailProfileViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 22/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileDetailsRequest.h"

@interface DetailProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

-(id)initWithContactID:(NSString*)contactID;

@end
