//
//  Foursquare2.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 20/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSRequester.h"
#ifndef __MAC_OS_X_VERSION_MAX_ALLOWED
#endif

typedef void(^Foursquare2Callback)(BOOL success, id result);

typedef enum
{
	intentCheckin,
	intentBrowse,
	intentGlobal,
	intentMatch
} FoursquareIntentType;

@interface Foursquare2 : FSRequester {
	
}

+(void)setBaseURL:(NSString*)uri;
+(void)searchVenuesNearByLatitude:(NSNumber*)lat longitude:(NSNumber*)lon section:(NSString*)section query:(NSString*)query intent:(FoursquareIntentType)intent radius:(NSNumber*)radius callback:(Foursquare2Callback)callback;
+(void)searchVenuesNearByLatitude:(NSNumber*)lat longitude:(NSNumber*)lon accuracyLL:(NSNumber*)accuracyLL altitude:(NSNumber*)altitude accuracyAlt:(NSNumber*)accuracyAlt section:(NSString*)section query:(NSString*)query limit:(NSNumber*)limit intent:(FoursquareIntentType)intent radius:(NSNumber*)radius categoryId:(NSString*)categoryId callback:(Foursquare2Callback)callback;

@end
