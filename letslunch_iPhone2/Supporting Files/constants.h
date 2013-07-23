//
//  constants.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 28/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#ifndef letslunch_iPhone2_constants_h
#define letslunch_iPhone2_constants_h

#warning remember to add this information!

/*
 Constants for Foursquare API
 */
// Base URL for Foursquare
#ifndef FS2_API_BaseUrl
#define FS2_API_BaseUrl @"https://api.foursquare.com/v2/"
#endif

// API key
#ifndef FS2_OAUTH_KEY
#define FS2_OAUTH_KEY (@"")
#endif

// API password
#ifndef FS2_OAUTH_SECRET
#define FS2_OAUTH_SECRET (@"")
#endif

// Redirect API
#ifndef FS2_REDIRECT_URL
#define FS2_REDIRECT_URL @""
#endif

// Date of version
#ifndef FS2_API_VERSION
#define FS2_API_VERSION (@"20130620")
#endif


/*
 Constants for Facebook API
 */
// API key
#ifndef FB_OAUTH_KEY
#define FB_OAUTH_KEY (@"")
#endif


/*
 Constants for LinkedIn API
 */
// Base URL for LinkedIn
#ifndef LK_API_URL
#define LK_API_URL (@"https://www.linkedin.com/uas/oauth2/")
#endif

// API key
#ifndef LK_API_KEY
#define LK_API_KEY (@"")
#endif

// Secret key
#ifndef LK_API_SECRET
#define LK_API_SECRET (@"")
#endif

// User token
#ifndef LK_API_USER_KEY
#define LK_API_USER_KEY (@"")
#endif

// User secret
#ifndef LK_API_USER_SECRET
#define LK_API_USER_SECRET (@"")
#endif

// Random number
#ifndef LK_API_STATE
#define LK_API_STATE (@"")
#endif

// Base URL for redirect
#ifndef LK_API_REDIRECT
#define LK_API_REDIRECT (@"http://letslunch.com/")
#endif

/*
 Constants for Twitter API
 */

// Base URL for Twitter
#ifndef TW_API_BaseUrl
#define TW_API_BaseUrl @"https://api.twitter.com/1.1/"
#endif

// API key
#ifndef TW_OAUTH_KEY
#define TW_OAUTH_KEY (@"")
#endif

// API password
#ifndef TW_OAUTH_SECRET
#define TW_OAUTH_SECRET (@"")
#endif


/*
 Constants for Base Website
 */

// Base URL for Let's Lunch
#ifndef LL_API_BaseUrl
#define LL_API_BaseUrl @""
#endif

// URL for default picture image
#ifndef LL_Default_Picture_Url
#define LL_Default_Picture_Url @""
#endif

#endif
