//
//  hmac.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#ifndef HMAC_H
#define HMAC_H 1

extern void hmac_sha1(const u_int8_t *inText, size_t inTextLength, u_int8_t* inKey, const size_t inKeyLength, u_int8_t *outDigest);

#endif /* HMAC_H */