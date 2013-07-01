//
//  OAServiceTicket.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAMutableURLRequest.h"


@interface OAServiceTicket : NSObject {
@private
    OAMutableURLRequest *request;
    NSURLResponse *response;
	NSData *data;
    BOOL didSucceed;
}
@property(readonly) OAMutableURLRequest *request;
@property(readonly) NSURLResponse *response;
@property(readonly) NSData *data;
@property(readonly) BOOL didSucceed;
@property(readonly) NSString *body;

- (id)initWithRequest:(OAMutableURLRequest *)aRequest response:(NSURLResponse *)aResponse data:(NSData *)aData didSucceed:(BOOL)success;

@end
