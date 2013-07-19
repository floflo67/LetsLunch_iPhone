//
//  FSTargetCallback.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 20/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "FSTargetCallback.h"


@implementation FSTargetCallback

@synthesize targetObject;
@synthesize targetCallback;
@synthesize resultCallback;
@synthesize requestUrl;
@synthesize request;
@synthesize numTries;
@synthesize callback;
@synthesize receivedData;


-(id)initWithCallback:(callback_block )callback_ resultCallback:(SEL)aResultCallback requestUrl:(NSString*)aRequestUrl numTries:(int)numberTries
{
    self = [super init];
    if (self) {
        self.callback = callback_;
        self.resultCallback = aResultCallback;
        self.requestUrl = aRequestUrl;
        self.numTries = numberTries;
    }
	return self;
}

- (void)dealloc
{
    [self.targetObject release];
    self.targetCallback = nil;
    self.resultCallback = nil;
    [self.requestUrl release];
    [self.request release];
    self.callback = nil;
    [self.receivedData release];
    [super dealloc];
}

@end
