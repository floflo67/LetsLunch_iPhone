//
//  ShareViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 27/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareViewController : UIViewController

+(ShareViewController*)getSingleton;
+(void)suppressSingleton;

@end
