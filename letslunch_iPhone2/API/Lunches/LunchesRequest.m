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

@interface LunchesRequest()
@property (nonatomic, strong) NSURLConnection* connection;
@property (nonatomic, strong) NSMutableData* data;
@property (nonatomic) NSInteger statusCode;
@property (nonatomic, strong) NSMutableDictionary *jsonDict;
@end

@implementation LunchesRequest

#pragma mark - GET owner lunch

+ (NSDictionary*)getOwnerLunchWithToken:(NSString*)token
{
    return [[[LunchesRequest alloc] init] getOwnerLunchWithToken:token];
}

/*
 URL: http://letslunch.dev.knackforge.com/lunch/show
 Request Type: POST
 Parameters:
    authToken
 */
- (NSDictionary*)getOwnerLunchWithToken:(NSString*)token
{
    /*
     Sets the body of the requests
     */
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:token forKey:@"authToken"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@lunch/show",LL_API_BaseUrl]];
    MutableRequest *request = [[MutableRequest alloc] initWithURL:url andParameters:parameters andType:@"POST"];
    
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    if(data)
        return [self settingUpData:data andResponse:response];
    else {
        [AppDelegate showNoConnectionMessage];
        return nil;
    }
}

- (NSDictionary*)settingUpData:(NSData*)data andResponse:(NSURLResponse*)response
{
    NSInteger statusCode = [(NSHTTPURLResponse*)response statusCode];
    NSArray *arr = [[NSArray alloc] initWithArray:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
    if([arr count] == 0)
        statusCode = 201;
    
    if(statusCode == 200) {
        NSDictionary *dict = arr[0];
        return [self createActivityDictionnaryWithDictionnary:dict];
    }
    else if (statusCode == 201)
        return nil;
    else {
        NSString* response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [AppDelegate showErrorMessage:response withErrorStatus:statusCode];
        NSLog(@"lunchrequest err1 %@", response);
        return nil;
    }
}

#pragma mark - Get people lunch

+ (NSMutableArray*)getLunchesWithToken:(NSString*)token latitude:(double)latitude longitude:(double)longitude andDate:(NSString*)date
{
    return [[[LunchesRequest alloc] init] getLunchesWithToken:token latitude:latitude longitude:longitude andDate:date];
}

/*
 URL: http://letslunch.dev.knackforge.com/lunch/show
 Request Type: POST
 Parameters:
     authToken
     degreesLatitude
     degreesLongitude
     lunchDate
 */
- (NSMutableArray*)getLunchesWithToken:(NSString*)token latitude:(double)latitude longitude:(double)longitude andDate:(NSString*)date
{
    /*
     Sets the body of the requests
     */
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:token forKey:@"authToken"];
    [parameters setValue:[NSString stringWithFormat:@"%f", latitude] forKey:@"degreesLatitude"];
    [parameters setValue:[NSString stringWithFormat:@"%f", longitude] forKey:@"degreesLongitude"];
    [parameters setValue:date forKey:@"lunchDate"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@lunch/people/nearby",LL_API_BaseUrl]];
    MutableRequest *request = [[MutableRequest alloc] initWithURL:url andParameters:parameters andType:@"POST"];
    
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    if(data)
        return [self settingUpLunchesData:data andResponse:response];
    else {
        [AppDelegate showNoConnectionMessage];
        return nil;
    }
}

- (NSMutableArray*)settingUpLunchesData:(NSData*)data andResponse:(NSURLResponse*)response
{
    NSInteger statusCode = [(NSHTTPURLResponse*)response statusCode];
    NSArray *arr = [[NSArray alloc] initWithArray:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
    if([arr count] == 0)
        statusCode = 201;
    
    if(statusCode == 200) {
        NSMutableArray *listLunch = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in arr) {
            [listLunch addObject:[[Activity alloc] initWithDict:[self createActivityDictionnaryWithDictionnary:dict]]];
        }
        return listLunch;
    }
    else if (statusCode == 201)
        return nil;
    else {
        NSString* response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [AppDelegate showErrorMessage:response withErrorStatus:statusCode];
        NSLog(@"lunchrequest err2 %@", response);
        return nil;
    }
}

#pragma mark - custom function

- (NSDictionary*)createActivityDictionnaryWithDictionnary:(NSDictionary*)dict
{
    NSMutableDictionary *activityDict = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *venueDict = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *locationDict = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *contactDict = [[NSMutableDictionary alloc] init];
    NSDictionary *userDict = [dict objectForKey:@"users"][0];
    
    [locationDict setObject:[dict objectForKey:@"degreesLatitude"] forKey:@"degreesLatitude"];
    [locationDict setObject:[dict objectForKey:@"degreesLongitude"] forKey:@"degreesLongitude"];
    [locationDict setObject:[dict objectForKey:@"venueAddress"] forKey:@"venueAddress"];
    
    [venueDict setObject:[dict objectForKey:@"venueName"] forKey:@"venueName"];
    [venueDict setObject:[dict objectForKey:@"venueId"] forKey:@"venueId"];
    [venueDict setObject:locationDict forKey:@"location"];
    
    [contactDict setObject:[userDict objectForKey:@"uid"] forKey:@"uid"];
    [contactDict setObject:[userDict objectForKey:@"firstname"] forKey:@"firstname"];
    [contactDict setObject:[userDict objectForKey:@"lastname"] forKey:@"lastname"];
    [contactDict setObject:[userDict objectForKey:@"headline"] forKey:@"headline"];
    [contactDict setObject:[userDict objectForKey:@"pictureUrl"] forKey:@"pictureURL"];
    
    [activityDict setObject:[dict objectForKey:@"lunchId"] forKey:@"id"];
    [activityDict setObject:@"0" forKey:@"isCoffee"];
    [activityDict setObject:contactDict forKey:@"contact"];
    [activityDict setObject:venueDict forKey:@"venue"];
    [activityDict setObject:[dict objectForKey:@"description"] forKey:@"description"];
    
    NSDateFormatter *formatToDate = [[NSDateFormatter alloc] init];
    NSDateFormatter *formatFromDate = [[NSDateFormatter alloc] init];
    [formatToDate setDateStyle:NSDateFormatterMediumStyle];
    [formatToDate setDateFormat:@"HH:mm:ss"];
    [formatFromDate setDateFormat:@"h:mm a"];
    
    NSDate *date = [[NSDate alloc] init];
    date = [formatToDate dateFromString:[dict objectForKey:@"startTime"]];
    NSString *time = [formatFromDate stringFromDate:date];
    [activityDict setObject:time forKey:@"startTime"];
    
    date = [formatToDate dateFromString:[dict objectForKey:@"endTime"]];
    time = [formatFromDate stringFromDate:date];
    [activityDict setObject:time forKey:@"endTime"];
    
    return activityDict;
}

#pragma mark - ADD lunch

/*
 URL: http://letslunch.dev.knackforge.com/api/lunch/create
 Request Type: POST
 Parameters:
    authToken
    lunchType
    lunchDate
    postingTime
    description
    degreesLatitude
    degreesLongitude
    venueName // can be null - depend on venue
    venueId // can be null - depend on venue
    venueAddress // can be null - depend on venue
 */
- (NSDictionary*)addLunchWithToken:(NSString*)token andActivity:(Activity*)activity
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    
    NSString *lunchType;
    if(activity.isCoffee)
        lunchType = @"coffee";
    else
        lunchType = @"lunch";
    
    NSString *lunchDate;
    NSString *postingTime;
    NSString *endTime;
    NSDate *date = [NSDate new];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    [format setDateFormat:@"YYYY-MM-dd"];
    lunchDate = [format stringFromDate:date];
    
    [format setDateFormat:@"HH:mm:ss"];
    postingTime = [format stringFromDate:date];
    
    NSTimeInterval secondsInThreeHours = 3 * 60 * 60;
    date = [date dateByAddingTimeInterval:secondsInThreeHours];
    endTime = [format stringFromDate:date];
    
    [parameters setValue:token forKey:@"authToken"];
    [parameters setValue:lunchType forKey:@"lunchType"];
    [parameters setValue:lunchDate forKey:@"lunchDate"];
    [parameters setValue:postingTime forKey:@"startTime"];
    [parameters setValue:endTime forKey:@"endTime"];
    [parameters setValue:activity.description forKey:@"description"];
    [parameters setValue:activity.venue.name forKey:@"venueName"];
    [parameters setValue:activity.venue.venueId forKey:@"venueId"];
    [parameters setValue:[NSString stringWithFormat:@"%f", activity.venue.location.coordinate.latitude] forKey:@"degreesLatitude"];
    [parameters setValue:[NSString stringWithFormat:@"%f", activity.venue.location.coordinate.longitude] forKey:@"degreesLongitude"];
    [parameters setValue:activity.venue.location.address forKey:@"venueAddress"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@lunch/create",LL_API_BaseUrl]];
    MutableRequest *request = [[MutableRequest alloc] initWithURL:url andParameters:parameters andType:@"POST"];
    
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    if(data)
        return [self settingUpDataForAdd:data andResponse:response];
    else {
        [AppDelegate showNoConnectionMessage];
        return nil;
    }
}

- (NSDictionary*)settingUpDataForAdd:(NSData*)data andResponse:(NSURLResponse*)response
{
    NSInteger statusCode = [(NSHTTPURLResponse*)response statusCode];
    
    if(statusCode == 200) {
        NSDictionary *dictJson = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        return dictJson;
    }
    else {
        NSDictionary *dictJson = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        NSDictionary *dictError = [NSDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithDictionary:[dictJson objectForKey:@"error"]]];
		NSString* response = [dictError objectForKey:@"message"];
        [AppDelegate showErrorMessage:response withErrorStatus:statusCode];
        return NO;
    }
}

#pragma mark - DELETE lunch

+ (BOOL)suppressLunchWithToken:(NSString*)token andActivityID:(NSString*)activityID
{
    return [[[LunchesRequest alloc] init] suppressLunchWithToken:token andActivityID:activityID];
}

/*
 URL: http://letslunch.dev.knackforge.com/api/me/lunch/cancel
 Request Type: POST
 Parameters:
    authToken
    id // to know which is selected
 */
- (BOOL)suppressLunchWithToken:(NSString*)token andActivityID:(NSString*)activityID
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:token forKey:@"authToken"];
    [parameters setValue:activityID forKey:@"id"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@me/lunch/cancel",LL_API_BaseUrl]];
    MutableRequest *request = [[MutableRequest alloc] initWithURL:url andParameters:parameters andType:@"POST"];
    
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    if(data)
        return [self settingUpDataForDelete:data andResponse:response];
    else {
        [AppDelegate showNoConnectionMessage];
        return NO;
    }
}

- (BOOL)settingUpDataForDelete:(NSData*)data andResponse:(NSURLResponse*)response
{
    NSInteger statusCode = [(NSHTTPURLResponse*)response statusCode];
    
    if(statusCode == 200) {
        return YES;
    }
    else {
        NSDictionary *dictJson = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        NSDictionary *dictError = [NSDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithDictionary:[dictJson objectForKey:@"error"]]];
		NSString* response = [dictError objectForKey:@"message"];
        [AppDelegate showErrorMessage:response withErrorStatus:statusCode];
        return NO;
    }
}

#pragma mark - UPDATE lunch

/*
 URL: http://letslunch.dev.knackforge.com/api/lunch/edit
 Request Type: POST
 Parameters:
    authToken
    lunchType
    availabilityID // to know which is selected
    postingTime
    description
    degreesLatitude
    degreesLongitude
    name // can be null - depend on venue
    id // can be null - depend on venue
    address // can be null - depend on venue
 */
- (void)updateLunchWithToken:(NSString*)token andActivity:(Activity*)activity
{
    if (self.connection == nil) {
        NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
        
        NSString *lunchType;
        if(activity.isCoffee)
            lunchType = @"coffee";
        else
            lunchType = @"lunch";
        
        NSString *postingTime;
        NSString *endTime;
        NSString *lunchDate;
        NSDate *date = [NSDate new];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        
        [format setDateFormat:@"YYYY-MM-dd"];
        lunchDate = [format stringFromDate:date];
        
        [format setDateFormat:@"HH:mm:ss"];
        postingTime = [format stringFromDate:date];
        
        NSTimeInterval secondsInThreeHours = 3 * 60 * 60;
        date = [date dateByAddingTimeInterval:secondsInThreeHours];
        endTime = [format stringFromDate:date];
        
        [parameters setValue:activity.activityID forKey:@"id"];
        [parameters setValue:token forKey:@"authToken"];
        [parameters setValue:lunchType forKey:@"lunchType"];
        [parameters setValue:postingTime forKey:@"startTime"];
        [parameters setValue:endTime forKey:@"endTime"];
        [parameters setValue:lunchDate forKey:@"lunchDate"];
        [parameters setValue:activity.description forKey:@"description"];
        [parameters setValue:activity.venue.name forKey:@"venueName"];
        [parameters setValue:activity.venue.venueId forKey:@"venueId"];
        [parameters setValue:[NSString stringWithFormat:@"%f", activity.venue.location.coordinate.latitude] forKey:@"degreesLatitude"];
        [parameters setValue:[NSString stringWithFormat:@"%f", activity.venue.location.coordinate.longitude] forKey:@"degreesLongitude"];
        [parameters setValue:activity.venue.location.address forKey:@"venueAddress"];
        [parameters setValue:activity.activityID forKey:@"availabilityID"];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@lunch/edit",LL_API_BaseUrl]];
        MutableRequest *request = [[MutableRequest alloc] initWithURL:url andParameters:parameters andType:@"POST"];
        
        self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    }
}

#pragma connection delegate

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
    [AppDelegate showNoConnectionMessage];
	self.connection = nil;
	self.data = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection
{
	if (self.statusCode != 200) {
        NSDictionary *dictJson = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:self.data options:0 error:nil]];
        NSDictionary *dictError = [NSDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithDictionary:[dictJson objectForKey:@"error"]]];
		NSString* response = [dictError objectForKey:@"message"];
        [AppDelegate showErrorMessage:response withErrorStatus:self.statusCode ? self.statusCode : 500];
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

- (NSMutableDictionary*)jsonDict
{
    if(!_jsonDict)
        _jsonDict = [[NSMutableDictionary alloc] init];
    return _jsonDict;
}

@end
