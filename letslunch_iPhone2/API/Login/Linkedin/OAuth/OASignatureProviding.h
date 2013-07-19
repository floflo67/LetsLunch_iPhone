//
//  OASignatureProviding.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol OASignatureProviding

- (NSString *)name;
- (NSString *)signClearText:(NSString *)text withSecret:(NSString *)secret;

@end
