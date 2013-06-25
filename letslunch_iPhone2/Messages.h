//
//  Messages.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 24/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Messages : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *contactIDFrom;
@property (nonatomic, strong) NSString *contactIDTo;
@property (nonatomic, strong) NSDate *date;

-(id)initWithDict:(NSDictionary*)dict;

@end
