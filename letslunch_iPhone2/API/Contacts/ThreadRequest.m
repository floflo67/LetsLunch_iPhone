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
        [AppDelegate showErrorMessage:response withTitle:[NSString stringWithFormat:@"%d", statusCode]];
        NSLog(@"thread err1 %@", response);
        return nil;
    }
}

- (Thread*)creatingThreadWithDict:(NSDictionary*)dictionary
{
    NSDictionary *latest = [dictionary objectForKey:@"latest"];
    NSDictionary *receiver = [dictionary objectForKey:@"receivers"][0];
    
    Thread *thread = [[Thread alloc] initWithID:[dictionary objectForKey:@"id"] receiver:[[Contacts alloc] initWithDictionary:receiver] lastMessage:[[Messages alloc] initWithDescription:[latest objectForKey:@"message"] userID:nil date:[dictionary objectForKey:@"timeStamp"]] andType:[dictionary objectForKey:@"type"]];
    
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
        
        NSMutableDictionary *dictMessages = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        NSArray *array = [dictMessages objectForKey:@"messages"];
        NSMutableArray *messages = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in array) {            
            [messages addObject:[[Messages alloc] initWithDictionary:dict]];
        }
        return messages;
    }
    else {
        NSMutableDictionary *dictError = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        dictError = [dictError objectForKey:@"error"];
        [AppDelegate showErrorMessage:[dictError objectForKey:@"message"]  withTitle:[NSString stringWithFormat:@"%d", statusCode]];
        return nil;
    }
}

@end
