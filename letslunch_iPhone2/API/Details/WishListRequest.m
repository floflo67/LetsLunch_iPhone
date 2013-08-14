//
//  WishListRequest.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 08/08/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "WishListRequest.h"
#import "MutableRequest.h"

@interface WishListRequest()
@property (nonatomic, strong) NSURLConnection* connection;
@property (nonatomic, strong) NSMutableData* data;
@property (nonatomic) NSInteger statusCode;
@end

@implementation WishListRequest

+ (void)changeUserFromWishList:(NSString*)userID withToken:(NSString*)token
{
    [[[WishListRequest alloc] init] changeUserFromWishList:userID withToken:token];
}

/*
 Url: http://letslunch.dev.knackforge.com/api/wishlist/change
 Parameters:
    authToken
    id
 */
- (void)changeUserFromWishList:(NSString*)userID withToken:(NSString*)token
{
    if (self.connection == nil) {
        NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
        [parameters setValue:token forKey:@"authToken"];
        [parameters setValue:userID forKey:@"followeeUid"];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@wishlist/change",LL_API_BaseUrl]];
        MutableRequest *request = [[MutableRequest alloc] initWithURL:url andParameters:parameters andType:@"POST"];
        
        self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    }
}

#pragma mark - connection delegate

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
	[self.data appendData:data];
}

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSHTTPURLResponse*)response
{
	self.statusCode = [response statusCode];
}

- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
	[AppDelegate showErrorMessage:error.localizedDescription withTitle:@"500"];
    self.connection = nil;
	self.data = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection
{    
	if (self.statusCode != 200) {
        NSDictionary *dictJson = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:self.data options:0 error:nil]];
        NSDictionary *dictError = [NSDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithDictionary:[dictJson objectForKey:@"error"]]];
		NSString* response = [dictError objectForKey:@"message"];
        NSLog(@"message %@", response);
	}
	
	self.connection = nil;
	self.data = nil;
}

#pragma mark - getter and setter

- (NSMutableData*)data
{
    if(!_data)
        _data = [NSMutableData new];
    return _data;
}

@end
