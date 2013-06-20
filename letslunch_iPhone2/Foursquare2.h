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

//1
#ifndef FS2_OAUTH_KEY
#define FS2_OAUTH_KEY    (@"5P1OVCFK0CCVCQ5GBBCWRFGUVNX5R4WGKHL2DGJGZ32FDFKT")
#endif

#ifndef FS2_OAUTH_SECRET
#define FS2_OAUTH_SECRET (@"UPZJO0A0XL44IHCD1KQBMAYGCZ45Z03BORJZZJXELPWHPSAR")
#endif

//2, don't forget to added app url in your info plist file CFBundleURLTypes
#ifndef FS2_REDIRECT_URL
#define FS2_REDIRECT_URL @"app://testapp123"
#endif

//3 update this date to use up-to-date Foursquare API
#ifndef FS2_API_VERSION
#define FS2_API_VERSION (@"20130620")
#endif


#define FS2_API_BaseUrl @"https://api.foursquare.com/v2/"

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

+(void)setBaseURL:(NSString *)uri;
+(void)searchVenuesNearByLatitude:(NSNumber*)lat longitude:(NSNumber*)lon query:(NSString*)query intent:(FoursquareIntentType)intent radius:(NSNumber*)radius callback:(Foursquare2Callback)callback;
+(void)searchVenuesNearByLatitude:(NSNumber*)lat longitude:(NSNumber*)lon accuracyLL:(NSNumber*)accuracyLL altitude:(NSNumber*)altitude accuracyAlt:(NSNumber*)accuracyAlt query:(NSString*)query limit:(NSNumber*)limit intent:(FoursquareIntentType)intent radius:(NSNumber*)radius categoryId:(NSString*)categoryId callback:(Foursquare2Callback)callback;

@end
