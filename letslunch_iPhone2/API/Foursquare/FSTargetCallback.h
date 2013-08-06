//
//  FSTargetCallback.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 20/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^callback_block)(BOOL success, id result);

@interface FSTargetCallback : NSObject {
	SEL				targetCallback;
	SEL				resultCallback;
	NSMutableData	*receivedData;		
	
	NSString		*requestUrl;
	NSURLRequest	*request;
	
	int				numTries;
}

@property (nonatomic, strong)	id targetObject;
@property (assign, nonatomic) SEL targetCallback;
@property (assign, nonatomic) SEL resultCallback;
@property (copy, nonatomic)	NSString *requestUrl;
@property (nonatomic, strong) NSURLRequest *request;
@property (assign, nonatomic) int numTries;
@property (copy, nonatomic) callback_block callback;
@property (nonatomic, strong) NSMutableData	*receivedData;

-(id)initWithCallback:(callback_block)callback_ resultCallback:(SEL)aResultCallback requestUrl:(NSString*)aRequestUrl numTries:(int)numberTries;

@end
