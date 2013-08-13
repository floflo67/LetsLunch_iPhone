//
//  Foursquare2.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 20/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "Foursquare2.h"
#import "FSTargetCallback.h"

@interface Foursquare2 (PrivateAPI)
+(void)get:(NSString*)methodName withParams:(NSDictionary*)params callback:(Foursquare2Callback)callback;
+(void)request:(NSString*)methodName withParams:(NSDictionary*)params httpMethod:(NSString*)httpMethod callback:(Foursquare2Callback)callback;

+ (NSMutableDictionary*)classAttributes;
@end

@implementation Foursquare2

static NSMutableDictionary *attributes;

+ (void)initialize
{
    [self setBaseURL:FS2_API_BaseUrl];
	NSUserDefaults *usDef = [NSUserDefaults standardUserDefaults];
	if ([usDef objectForKey:@"access_token2"] != nil) {
		[self classAttributes][@"access_token"] = [usDef objectForKey:@"access_token2"];
	}
}

+ (void)setBaseURL:(NSString*)uri
{
    [self setAttributeValue:uri forKey:@"FS2_API_BaseUrl"];
}

+ (void)setAttributeValue:(id)attr forKey:(NSString*)key
{
    [self classAttributes][key] = attr;
}

+ (NSMutableDictionary*)classAttributes
{
    if(attributes) {
        return attributes;
    } else {
        attributes = [[NSMutableDictionary alloc] init];
    }
    
    return attributes;
}

+(NSString*)stringFromArray:(NSArray*)array
{
	if (array.count) {
        return [array componentsJoinedByString:@","];
    }
    return @"";
	
}

#pragma mark - Venues

+(void)getDetailForVenue:(NSString*)venueID callback:(Foursquare2Callback)callback
{
	NSString *path = [NSString stringWithFormat:@"venues/%@",venueID];
	[self get:path withParams:nil callback:callback];
}

+(void)getVenueCategoriesCallback:(Foursquare2Callback)callback
{
	[self get:@"venues/categories" withParams:nil callback:callback];
}

+(void)searchVenuesNearByLatitude:(NSNumber*)lat longitude:(NSNumber*)lon section:(NSString*)section query:(NSString*)query intent:(FoursquareIntentType)intent radius:(NSNumber*)radius callback:(Foursquare2Callback)callback
{
	NSMutableDictionary *dic = [NSMutableDictionary dictionary];
	if (lat && lon)
		dic[@"ll"] = [NSString stringWithFormat:@"%@,%@",lat,lon];
    if(section)
        dic[@"section"] = section;
	if (query)
		dic[@"query"] = query;
	if (intent)
		dic[@"intent"] = [self inentTypeToString:intent];
    if (radius)
		dic[@"radius"] = radius.stringValue;
    
    if(section)
        [self get:@"venues/explore" withParams:dic callback:callback];
    else
        [self get:@"venues/search" withParams:dic callback:callback];
}

+(void)searchVenuesNearByLatitude:(NSNumber*)lat longitude:(NSNumber*)lon accuracyLL:(NSNumber*)accuracyLL altitude:(NSNumber*)altitude accuracyAlt:(NSNumber*)accuracyAlt section:(NSString*)section query:(NSString*)query limit:(NSNumber*)limit intent:(FoursquareIntentType)intent radius:(NSNumber*)radius categoryId:(NSString*)categoryId callback:(Foursquare2Callback)callback
{
	NSMutableDictionary *dic = [NSMutableDictionary dictionary];
	if (lat && lon) {
		dic[@"ll"] = [NSString stringWithFormat:@"%@,%@",lat,lon];
	}
	if (accuracyLL) {
		dic[@"llAcc"] = accuracyLL.stringValue;
	}
	if (altitude) {
		dic[@"alt"] = altitude.stringValue;
	}
	if (accuracyAlt) {
		dic[@"altAcc"] = accuracyAlt.stringValue;
	}
    if(section) {
        dic[@"section"] = section;
    }
	if (query) {
		dic[@"query"] = query;
	}
	if (limit) {
		dic[@"limit"] = limit.stringValue;
	}
	if (intent) {
		dic[@"intent"] = [self inentTypeToString:intent];
	}
    if (radius) {
		dic[@"radius"] = radius.stringValue;
	}
    if (categoryId) {
        dic[@"categoryId"] = categoryId;
    }
    
    if(section)
        [self get:@"venues/explore" withParams:dic callback:callback];
    else
        [self get:@"venues/search" withParams:dic callback:callback];
}

#pragma mark - Private methods

+(NSString*)inentTypeToString:(FoursquareIntentType)broadcast
{
	switch (broadcast) {
		case intentBrowse:
			return @"browse";
			break;
		case intentCheckin:
			return @"checkin";
			break;
		case intentGlobal:
			return @"global";
			break;
		case intentMatch:
			return @"match";
			break;
		default:
			return nil;
			break;
	}
}

+ (void) get:(NSString*)methodName withParams:(NSDictionary*)params callback:(Foursquare2Callback)callback
{
	[self request:methodName withParams:params httpMethod:@"GET" callback:callback];
}

+ (NSString*)constructRequestUrlForMethod:(NSString*)methodName params:(NSDictionary*)paramMap
{
    NSMutableString *paramStr = [NSMutableString stringWithString: [self classAttributes][@"FS2_API_BaseUrl"]];
    
    [paramStr appendString:methodName];
	[paramStr appendFormat:@"?client_id=%@",FS2_OAUTH_KEY];
    [paramStr appendFormat:@"&client_secret=%@",FS2_OAUTH_SECRET];
    [paramStr appendFormat:@"&v=%@",FS2_API_VERSION];
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey: NSLocaleLanguageCode];
    [paramStr appendFormat:@"&locale=%@",countryCode];
    
	NSString *accessToken  = [self classAttributes][@"access_token"];
	if ([accessToken length] > 0)
        [paramStr appendFormat:@"&oauth_token=%@",accessToken];
	
	if(paramMap) {
		NSEnumerator *enumerator = [paramMap keyEnumerator];
		NSString *key, *value;
		
		while ((key = (NSString*)[enumerator nextObject])) {
			value = (NSString*)paramMap[key];
			//DLog(@"value: " @"%@", value);
			
			NSString *urlEncodedValue = [value stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];//NSASCIIStringEncoding];
			
			if(!urlEncodedValue) {
				urlEncodedValue = @"";
			}
			[paramStr appendFormat:@"&%@=%@",key,urlEncodedValue];
		}
	}
	return paramStr;
}

static Foursquare2 *instance;
+ (Foursquare2*) sharedInstance
{
    if (!instance) {
        instance = [[Foursquare2 alloc]init];
    }
    return instance;
    
}

+ (void) request:(NSString*)methodName withParams:(NSDictionary*)params httpMethod:(NSString*)httpMethod callback:(Foursquare2Callback)callback
{
    [[Foursquare2 sharedInstance] request:methodName withParams:params httpMethod:httpMethod callback:callback];   
}

- (void) callback: (NSDictionary*)d target:(FSTargetCallback*)target
{
    if (d[@"access_token"]) {
        target.callback(YES,d);
        return;
    }
    NSNumber *code = [d valueForKeyPath:@"meta.code"];
    if (d!= nil && (code.intValue == 200 || code.intValue == 201)) {
        target.callback(YES,d);
    }else{
        target.callback(NO,[d valueForKeyPath:@"meta.errorDetail"]);
    }
}

- (void) request:(NSString*)methodName withParams:(NSDictionary*)params httpMethod:(NSString*)httpMethod callback:(Foursquare2Callback)callback
{
    //	callback = [callback copy];
    NSString *path = [Foursquare2 constructRequestUrlForMethod:methodName
                                                        params:params];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:path]];
    request.HTTPMethod = httpMethod;
	
    FSTargetCallback *target = [[FSTargetCallback alloc] initWithCallback:callback
                                                       resultCallback:@selector(callback:target:)
                                                           requestUrl: path
                                                             numTries: 2];
	
	[self makeAsyncRequestWithRequest:request target:target];
}

@end
