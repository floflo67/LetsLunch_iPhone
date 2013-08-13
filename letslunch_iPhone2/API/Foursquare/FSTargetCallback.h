//
//  FSTargetCallback.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 20/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

typedef void(^callback_block)(BOOL success, id result);

@interface FSTargetCallback : NSObject {
	SEL	targetCallback;
	SEL	resultCallback;
	NSMutableData *receivedData;
	NSString *requestUrl;
	NSURLRequest *request;
	int	numTries;
}

@property (nonatomic, strong)	id targetObject;
@property (nonatomic, assign) SEL targetCallback;
@property (nonatomic, assign) SEL resultCallback;
@property (nonatomic, copy)	NSString *requestUrl;
@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, assign) int numTries;
@property (nonatomic, copy) callback_block callback;
@property (nonatomic, strong) NSMutableData	*receivedData;

-(id)initWithCallback:(callback_block)callback_ resultCallback:(SEL)aResultCallback requestUrl:(NSString*)aRequestUrl numTries:(int)numberTries;

@end
