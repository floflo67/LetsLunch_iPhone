//
//  MutableRequest.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 11/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MutableRequest : NSMutableURLRequest

-(id)initWithURL:(NSURL*)URL andParameters:(NSDictionary*)parameters andType:(NSString*)type;

@end
