//
//  FSTargetCallback.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 20/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "FSTargetCallback.h"

@interface FSTargetCallback()
@property (nonatomic, strong) NSMutableData	*receivedData;
@property (nonatomic, strong) id targetObject;
@property (nonatomic, strong) callback_block callback;
@property (nonatomic, assign) SEL resultCallback;
@property (nonatomic) NSInteger numTries;
@end

@implementation FSTargetCallback


- (id)initWithCallback:(callback_block)callback_ resultCallback:(SEL)aResultCallback numTries:(int)numberTries
{
    self = [super init];
    if (self) {
        self.callback = callback_;
        self.resultCallback = aResultCallback;
        self.numTries = numberTries;
    }
	return self;
}

- (void)setData:(NSMutableData*)data
{
    if(self.receivedData != data)
        self.receivedData = data;
}

@end
