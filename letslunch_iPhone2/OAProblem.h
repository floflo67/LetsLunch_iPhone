//
//  OAProblem.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
	kOAProblemSignatureMethodRejected = 0,
	kOAProblemParameterAbsent,
	kOAProblemVersionRejected,
	kOAProblemConsumerKeyUnknown,
	kOAProblemTokenRejected,
	kOAProblemSignatureInvalid,
	kOAProblemNonceUsed,
	kOAProblemTimestampRefused,
	kOAProblemTokenExpired,
	kOAProblemTokenNotRenewable
};

@interface OAProblem : NSObject {
	const NSString *problem;
}

@property (readonly) const NSString *problem;

- (id)initWithProblem:(const NSString *)aProblem;
- (id)initWithResponseBody:(const NSString *)response;

- (BOOL)isEqualToProblem:(OAProblem *)aProblem;
- (BOOL)isEqualToString:(const NSString *)aProblem;
- (BOOL)isEqualTo:(id)aProblem;
- (int)code;

+ (OAProblem *)problemWithResponseBody:(const NSString *)response;

+ (const NSArray *)validProblems;

+ (OAProblem *)SignatureMethodRejected;
+ (OAProblem *)ParameterAbsent;
+ (OAProblem *)VersionRejected;
+ (OAProblem *)ConsumerKeyUnknown;
+ (OAProblem *)TokenRejected;
+ (OAProblem *)SignatureInvalid;
+ (OAProblem *)NonceUsed;
+ (OAProblem *)TimestampRefused;
+ (OAProblem *)TokenExpired;
+ (OAProblem *)TokenNotRenewable;

@end
