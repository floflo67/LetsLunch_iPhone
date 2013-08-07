//
//  ThreadRequest.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 02/08/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "ThreadRequest.h"
#import "MutableRequest.h"
#import "Thread.h"

@implementation ThreadRequest

#pragma mark - list threads

+ (NSMutableArray*)getListThreadsWithToken:(NSString*)token
{
    return [[[ThreadRequest alloc] init] getListThreadsWithToken:token];
}

- (NSMutableArray*)getListThreadsWithToken:(NSString*)token
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:token forKey:@"authToken"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@me/message/threads",LL_API_BaseUrl]];
    MutableRequest *request = [[MutableRequest alloc] initWithURL:url andParameters:parameters andType:@"POST"];
    
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    if(data)
        return [self settingUpForThreadsData:data andResponse:response];
    else {
        [AppDelegate showNoConnectionMessage];
        return nil;
    }
}

- (NSMutableArray*)settingUpForThreadsData:(NSData*)data andResponse:(NSURLResponse*)response
{
    NSInteger statusCode = [(NSHTTPURLResponse*)response statusCode];
    
    if(statusCode == 200) {
        NSMutableArray *jsonArray = [[NSMutableArray alloc] init];
        NSArray *jsonDict = [NSArray arrayWithArray:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        for (NSDictionary *dict in jsonDict) {
            [jsonArray addObject:[self creatingThreadWithDict:dict]];
        }
        return jsonArray;
    }
    else {
        NSString* response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"thread err1 %@", response);
        return nil;
    }
}

- (Thread*)creatingThreadWithDict:(NSDictionary*)dictionary
{
    Thread *thread = [[Thread alloc] init];
    NSDictionary *latest = [dictionary objectForKey:@"latest"];
    NSDictionary *receiver = [dictionary objectForKey:@"receivers"][0];
    
    thread.lastMessage = [[Messages alloc] init];
    thread.lastMessage.description = [latest objectForKey:@"message"];
    
    NSString *date = [dictionary objectForKey:@"timeStamp"];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateDate = [format dateFromString:date];
    thread.lastMessage.date = dateDate;
    
    thread.receiver = [[Contacts alloc] initWithDictionary:receiver];
    thread.type = [dictionary objectForKey:@"type"];
    thread.ID = [dictionary objectForKey:@"id"];
    return thread;
}

#pragma mark - specific thread

+ (NSMutableArray*)getMessagesWithToken:(NSString*)token andThreadID:(NSString*)threadID
{
    return [[[ThreadRequest alloc] init] getMessagesWithToken:token andThreadID:threadID];
}

- (NSMutableArray*)getMessagesWithToken:(NSString*)token andThreadID:(NSString*)threadID
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:token forKey:@"authToken"];
    [parameters setValue:threadID forKey:@"id"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@me/message/thread",LL_API_BaseUrl]];
    MutableRequest *request = [[MutableRequest alloc] initWithURL:url andParameters:parameters andType:@"POST"];
    
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    if(data)
        return [self settingUpForMessagesData:data andResponse:response];
    else {
        [AppDelegate showNoConnectionMessage];
        return nil;
    }    
}

- (NSMutableArray*)settingUpForMessagesData:(NSData*)data andResponse:(NSURLResponse*)response
{
    NSInteger statusCode = [(NSHTTPURLResponse*)response statusCode];
    
    if(statusCode == 200) {
        
        NSArray *jsonDict = [NSArray arrayWithArray:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        NSLog(@"thread %@", jsonDict);
        return nil;
        /*
        for (NSDictionary *dict in jsonDict) {
            [self.jsonArray addObject:[self creatingThreadWithDict:dict]];
        }*/
    }
    else {
        NSString* response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"thread err3 %@", response);
        return nil;
    }
}

@end
