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

@interface ThreadRequest()
@property (nonatomic, strong) NSMutableArray *jsonArray;
@end

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
    
    [self settingUpForThreadsData:data andResponse:response];
    
    return self.jsonArray;
}

- (void)settingUpForThreadsData:(NSData*)data andResponse:(NSURLResponse*)response
{
    NSInteger statusCode = [(NSHTTPURLResponse*)response statusCode];
    
    if(statusCode == 200) {
        
        NSArray *jsonDict = [NSArray arrayWithArray:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        for (NSDictionary *dict in jsonDict) {
            [self.jsonArray addObject:[self creatingThreadWithDict:dict]];
        }
    }
    else {
        NSString* response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"thread err1 %@", response);
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
    
    [self settingUpForMessagesData:data andResponse:response];
    
    return self.jsonArray;
}

- (void)settingUpForMessagesData:(NSData*)data andResponse:(NSURLResponse*)response
{
    NSInteger statusCode = [(NSHTTPURLResponse*)response statusCode];
    
    if(statusCode == 200) {
        
        NSArray *jsonDict = [NSArray arrayWithArray:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        NSLog(@"thread %@", jsonDict);
        /*
        for (NSDictionary *dict in jsonDict) {
            [self.jsonArray addObject:[self creatingThreadWithDict:dict]];
        }*/
    }
    else {
        NSString* response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"thread err3 %@", response);
    }
}

#pragma mark - getter and setter

- (NSMutableArray *)jsonArray
{
    if(!_jsonArray)
        _jsonArray = [[NSMutableArray alloc] init];
    return _jsonArray;
}

@end
