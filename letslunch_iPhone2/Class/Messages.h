//
//  Messages.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 24/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

@interface Messages : NSObject

@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *contactIDFrom;
@property (nonatomic, strong) NSString *contactIDTo;
@property (nonatomic, strong) NSDate *date;

-(id)initWithDict:(NSDictionary*)dict;
-(id)initWithDescription:(NSString*)description From:(NSString*)from To:(NSString*)to date:(NSDate*)date;

@end
