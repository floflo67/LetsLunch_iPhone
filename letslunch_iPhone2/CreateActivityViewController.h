//
//  CreateActivityViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 14/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

@interface CreateActivityViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray* objects;

+(CreateActivityViewController*)getSingleton;

@end
