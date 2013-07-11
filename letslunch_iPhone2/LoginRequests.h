//
//  LoginRequests.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 10/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginRequestDelegate
-(void)showErrorMessage:(NSString*)message withErrorStatus:(NSInteger)errorStatus;
-(void)successfullConnection;
@end

@interface LoginRequests : NSObject {
@private
	id<LoginRequestDelegate> _delegate;
    NSURLConnection* _connection;
    NSMutableData* _data;
    NSInteger _statusCode;
}

@property (nonatomic,assign) id<LoginRequestDelegate> delegate;
    
-(BOOL)loginWithUserName:(NSString*)username andPassword:(NSString*)password;
-(BOOL)signUpWithUserName:(NSString*)username andPassword:(NSString*)password andMailAddress:(NSString*)email andCountry:(NSString*)country;
-(void)logout;

@end
