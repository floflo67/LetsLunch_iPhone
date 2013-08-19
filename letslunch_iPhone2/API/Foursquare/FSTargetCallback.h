//
//  FSTargetCallback.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 20/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

typedef void(^callback_block)(BOOL success, id result);

@interface FSTargetCallback : NSObject

@property (nonatomic, strong, readonly) NSMutableData *receivedData;
@property (nonatomic, strong, readonly) id targetObject;
@property (nonatomic, assign, readonly) SEL resultCallback;
@property (nonatomic, strong, readonly) callback_block callback;

-(id)initWithCallback:(callback_block)callback_ resultCallback:(SEL)aResultCallback numTries:(int)numberTries;
-(void)setData:(NSMutableData*)data;
@end
