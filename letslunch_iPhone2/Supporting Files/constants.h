//
//  constants.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 28/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#ifndef letslunch_iPhone2_constants_h
#define letslunch_iPhone2_constants_h

/*
 Constants for Foursquare API
 */
// Base URL for Foursquare
#ifndef FS2_API_BaseUrl
#define FS2_API_BaseUrl @"https://api.foursquare.com/v2/"
#endif

// API key
#ifndef FS2_OAUTH_KEY
#define FS2_OAUTH_KEY (@"2ZL4HYGZMGGZSDUKI55UXFFASPA4CB0TCS0Z21D0HNPGUPH2")
#endif

// API password
#ifndef FS2_OAUTH_SECRET
#define FS2_OAUTH_SECRET (@"II3LCE1OM4VXJGZNQCBXVCH1FFJBLODZF0RHGU2KSAG1UFEN")
#endif

// Redirect API
#ifndef FS2_REDIRECT_URL
#define FS2_REDIRECT_URL @"http://letslunch.com/"
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
#define FB_OAUTH_KEY (@"588630294501794")
#endif

// API password
#ifndef FB_OAUTH_KEY
#define FB_OAUTH_KEY (@"4c14228e52cd9dbf146bac8dd1bf003f")
#endif


/*
 Constants for LinkedIn API
 */
// Base URL for LinkedIn
#ifndef LI_API_BaseUrl
#define LI_API_BaseUrl @"http://api.linkedin.com/v1/"
#endif

// API key
#ifndef LI_OAUTH_KEY
#define LI_OAUTH_KEY (@"bu4scy6j1xfl")
#endif

// Secret key
#ifndef LI_OAUTH_SECRET
#define LI_OAUTH_SECRET (@"XxH5O6iZYY6vceQz")
#endif

// User token
#ifndef LI_OAUTH_USER_TOKEN
#define LI_OAUTH_USER_TOKEN (@"06f88b3d-d77b-4a3f-bca0-dccd8e029a31")
#endif

// User secret
#ifndef LI_OAUTH_USER_SECRET
#define LI_OAUTH_USER_SECRET (@"8150dfda-87b8-4e18-89ae-aa5a91c5fe9d")
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
#define TW_OAUTH_KEY (@"xH3RHvybSsqSQTEtvJ1g")
#endif

// API password
#ifndef TW_OAUTH_SECRET
#define TW_OAUTH_SECRET (@"FcSWBqwRiWGMTsHDZSCuxtWb6KjleujL9Bwja5SKyI")
#endif

// User token
#ifndef TW_OAUTH_USER_TOKEN
#define TW_OAUTH_USER_TOKEN (@"961028960-w9MqjZ2pYbRT3QDMM0P0QkskKNuU09ck5oMdkxQS")
#endif

// User secret
#ifndef TW_OAUTH_USER_SECRET
#define TW_OAUTH_USER_SECRET (@"xXBCQaBSqHbmajRJtHpspWToIl4S1qcfgiIcTtQc")
#endif


/*
 Constants for Base Website
 */

// Base URL for Let's Lunch
#ifndef LL_API_BaseUrl
#define LL_API_BaseUrl @"http://letslunch.dev.knackforge.com/api/"
#endif

// URL for default picture image
#ifndef LL_Default_Picture_Url
#define LL_Default_Picture_Url @"http://www.standard-icons.com/stock-icons/standard-dating/no_photo-icon.gif"
#endif

#endif
