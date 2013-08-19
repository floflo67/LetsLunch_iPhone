//
//  Messages.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 24/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

@interface Messages : NSObject

@property (nonatomic, strong, readonly) NSString *description;
@property (nonatomic, strong, readonly) NSString *contactID;
@property (nonatomic, strong, readonly) NSDate *date;

-(id)initWithDictionary:(NSDictionary*)dict;
-(id)initWithDescription:(NSString*)description userID:(NSString*)userID date:(NSString*)date;

@end
