//
//  ProfileViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 11/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileRequest.h"

@interface ProfileViewController : UITableViewController {
    ProfileRequest *_profileRequest;
}

@property (nonatomic, strong) NSMutableArray* objects;
@property (nonatomic, strong) ProfileRequest *profileRequest;

+(ProfileViewController*)getSingleton;

@end
