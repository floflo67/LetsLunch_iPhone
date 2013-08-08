//
//  Testimonials.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 08/08/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Testimonials : NSObject

@property (nonatomic, strong, readonly) NSString *message;
@property (nonatomic, strong, readonly) Contacts *user;

-(id)initWithDictionary:(NSDictionary*)dict;

@end
