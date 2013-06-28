//
//  constants.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 28/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#ifndef letslunch_iPhone2_constants_h
#define letslunch_iPhone2_constants_h

//1
#ifndef FS2_OAUTH_KEY
#define FS2_OAUTH_KEY (@"5P1OVCFK0CCVCQ5GBBCWRFGUVNX5R4WGKHL2DGJGZ32FDFKT")
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

#endif
