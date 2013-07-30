//
//  FSRequester.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 20/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#define TIMEOUT_INTERVAL 45

@class FSTargetCallback;
@interface FSRequester : NSObject{
    BOOL needToShowErrorAlert;
}

@property (strong,nonatomic) NSMutableArray *requestHistory;
@property (strong, nonatomic) NSMutableDictionary *asyncConnDict;

-(void)handleConnectionError:(NSError*)error;
-(void)makeAsyncRequest:(NSURL*)url target:(FSTargetCallback*)target;
-(void)makeAsyncRequestWithRequest:(NSURLRequest*)urlRequest target:(FSTargetCallback*)target;

@end
