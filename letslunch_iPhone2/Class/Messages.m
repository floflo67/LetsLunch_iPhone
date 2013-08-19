//
//  Messages.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 24/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "Messages.h"

@interface Messages()

@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *contactID;
@property (nonatomic, strong) NSDate *date;

@end

@implementation Messages

- (id)initWithDictionary:(NSDictionary*)dict
{
    self = [self init];
    if(self) {
        self.description = [dict objectForKey:@"message"];
        self.contactID = [dict objectForKey:@"uid"];
        
        id date = [dict objectForKey:@"timeStamp"];
        
        if([date class] == [NSDate class])
            self.date = date;
        else
            self.date = [self setupDate:date];
    }
    return self;
}

- (id)initWithDescription:(NSString*)description userID:(NSString*)userID date:(NSString*)date
{
    self = [self init];
    if(self) {
        self.description = description;
        self.contactID = userID;
        self.date = [self setupDate:date];
    }
    return self;
}

- (NSDate*)setupDate:(NSString*)stringDate
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateDate = [format dateFromString:stringDate];
    return dateDate;
}

@end
