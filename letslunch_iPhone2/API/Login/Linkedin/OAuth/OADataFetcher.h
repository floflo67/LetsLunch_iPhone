//
//  OADataFetcher.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAMutableURLRequest.h"
#import "OAServiceTicket.h"


@interface OADataFetcher : NSObject {
@private
    OAMutableURLRequest *request;
    NSURLResponse *response;
    NSURLConnection *connection;
    NSMutableData *responseData;
    id delegate;
    SEL didFinishSelector;
    SEL didFailSelector;
}

- (void)fetchDataWithRequest:(OAMutableURLRequest *)aRequest delegate:(id)aDelegate didFinishSelector:(SEL)finishSelector didFailSelector:(SEL)failSelector;

@end
