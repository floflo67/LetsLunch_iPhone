//
//  ContactViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 25/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

@interface ContactViewController : UITableViewController

+(ContactViewController*)getSingleton;
+(void)suppressSingleton;

@end
