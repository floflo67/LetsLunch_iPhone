//
//  ShareViewController.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 27/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

@interface ShareViewController : UIViewController <UIWebViewDelegate>

+(ShareViewController*)getSingleton;
+(void)suppressSingleton;

-(void)shareOnLinkedIn;

@end
