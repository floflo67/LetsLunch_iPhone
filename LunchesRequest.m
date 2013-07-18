//
//  LunchesRequest.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 17/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "LunchesRequest.h"
#import "MutableRequest.h"
#import "Activity.h"

@implementation LunchesRequest

#pragma mark - GET lunch

+ (NSDictionary*)getLunchWithToken:(NSString*)token
{
    LunchesRequest *lunchRequest = [[[LunchesRequest alloc] init] autorelease];
    return [lunchRequest getLunchWithToken:token];
}

- (NSDictionary*)getLunchWithToken:(NSString*)token
{
    /*
     Sets the body of the requests
     */
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:token forKey:@"authToken"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@me/availability",LL_API_BaseUrl]];
    MutableRequest *request = [[MutableRequest alloc] initWithURL:url andParameters:parameters andType:@"POST"];
    
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    [self settingUpData:data andResponse:response];
    
    return _jsonDict;
}

#pragma mark - ADD lunch

+ (void)addLunchWithToken:(NSString*)token andActivity:(Activity*)activity
{
    LunchesRequest *lunchRequest = [[[LunchesRequest alloc] init] autorelease];
    [lunchRequest addLunchWithToken:token andActivity:activity];
}

/*
 POST:
    authToken
    lunchType
    lunchDate
    postingTime
    description
    degreesLatitude
    degreesLongitude
    name // can be null - depend on venue
    id // can be null - depend on venue
    address // can be null - depend on venue
 */
- (void)addLunchWithToken:(NSString*)token andActivity:(Activity*)activity
{
    if (_connection == nil) {
		_data = [NSMutableData new];
        
        /*
         Sets the body of the requests
         Countains username, password and device ID
         */
        NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
        
        NSString *lunchType;
        if(activity.isCoffee)
            lunchType = @"Coffee";
        else
            lunchType = @"Lunch";
        
        NSString *lunchDate;
        NSString *postingTime;
        NSDate *date = [NSDate new];
        NSDateFormatter *format = [[[NSDateFormatter alloc] init] autorelease];
        
        [format setDateFormat:@"YY-MM-dd"];
        lunchDate = [format stringFromDate:date];
        
        [format setDateFormat:@"HH:mm"];
        postingTime = [format stringFromDate:date];
        
        [parameters setValue:token forKey:@"authToken"];
        [parameters setValue:lunchType forKey:@"lunchType"];
        [parameters setValue:lunchDate forKey:@"lunchDate"];
        [parameters setValue:postingTime forKey:@"postingTime"];
        [parameters setValue:activity.description forKey:@"description"];
        [parameters setValue:activity.venue.name forKey:@"name"];
        [parameters setValue:activity.venue.venueId forKey:@"id"];
        [parameters setValue:[NSString stringWithFormat:@"%f", activity.venue.location.coordinate.latitude] forKey:@"degreesLatitude"];
        [parameters setValue:[NSString stringWithFormat:@"%f", activity.venue.location.coordinate.longitude] forKey:@"degreesLongitude"];
        [parameters setValue:activity.venue.location.address forKey:@"address"];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@me/availability/add",LL_API_BaseUrl]];
        MutableRequest *request = [[MutableRequest alloc] initWithURL:url andParameters:parameters andType:@"POST"];
        
        _connection = [[NSURLConnection connectionWithRequest:request delegate:self] retain];
    }
}

#pragma mark - DELETE lunch

+ (NSDictionary *)suppressLunchWithToken:(NSString*)token andActivityID:(NSString*)activityID
{
    LunchesRequest *lunchRequest = [[[LunchesRequest alloc] init] autorelease];
    return [lunchRequest suppressLunchWithToken:token andActivityID:activityID];
}

- (NSDictionary *)suppressLunchWithToken:(NSString*)token andActivityID:(NSString*)activityID
{
    /*
     Sets the body of the requests
     Countains username, password and device ID
     */
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:token forKey:@"authToken"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@me",LL_API_BaseUrl]];
    MutableRequest *request = [[MutableRequest alloc] initWithURL:url andParameters:parameters andType:@"POST"];
    //_connection = [[NSURLConnection connectionWithRequest:request delegate:self] retain];
    
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    [self settingUpData:data andResponse:response];
    
    return _jsonDict;
}

#pragma mark - UPDATE lunch

+ (void)updateLunchWithToken:(NSString *)token andID:(NSString *)activityID andActivity:(Activity *)activity
{
    
}

- (void)updateLunchWithToken:(NSString *)token andID:(NSString *)activityID andActivity:(Activity *)activity
{
    
}

#pragma mark - custom function

- (void)settingUpData:(NSData*)data andResponse:(NSURLResponse*)response
{
    _statusCode = [(NSHTTPURLResponse*)response statusCode];
    NSString* res = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"%@", res);
    
    if(_statusCode == 200) {
        if(!_jsonDict)
            _jsonDict = [[NSMutableDictionary alloc] init];
        
        _jsonDict = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        NSMutableArray *array = [_jsonDict objectForKey:@"lunchAvailabilty"];
        
        if(array.count > 0) {
            
        }
        else
            _jsonDict = nil;
        
        _jsonDict = [_jsonDict objectForKey:@"user"];
    }
    else {
        NSString* response = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
        NSLog(@"%@", response);
    }
}

- (void)showErrorMessage:(NSString*)error
{
    [_delegate showErrorMessage:error withErrorStatus:_statusCode];
}

#pragma connection delegate

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
	[_data appendData:data];
}

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSHTTPURLResponse*)response
{
	_statusCode = [response statusCode];
}

- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
	[_connection release];
	_connection = nil;
	
	[_data release];
	_data = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    
    NSString* response = [[[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"%@", response);
    
	if (_statusCode != 200) {
        NSDictionary *dictJson = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:_data options:0 error:nil]];
        NSDictionary *dictError = [NSDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithDictionary:[dictJson objectForKey:@"error"]]];
		NSString* response = [dictError objectForKey:@"message"];
        [self showErrorMessage:response];
	}
	
	[_connection release];
	_connection = nil;
	
	[_data release];
	_data = nil;
}

#pragma lifecycle

- (void)dealloc
{
    [_jsonDict release];
    [super dealloc];
}

@end
