//
//  Activity.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 24/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSVenue.h"
#import "Contacts.h"

@interface Activity : NSObject

@property (nonatomic, strong) Contacts *contact;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) FSVenue *venue;
@property (nonatomic) BOOL isCoffee;

-(id)initWithDict:(NSDictionary*)dict;
-(id)initWithContact:(Contacts*)contact venue:(FSVenue*)venue description:(NSString*)description andIsCoffee:(BOOL)isCoffee;

@end
