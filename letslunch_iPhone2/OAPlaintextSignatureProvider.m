//
//  OAPlaintextSignatureProvider.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "OAPlaintextSignatureProvider.h"


@implementation OAPlaintextSignatureProvider

- (NSString *)name {
    return @"PLAINTEXT";
}

- (NSString *)signClearText:(NSString *)text withSecret:(NSString *)secret {
    return secret;
}

@end
