//
//  Base64Transcoder.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#include <stdlib.h>
#include <stdbool.h>

extern size_t EstimateBas64EncodedDataSize(size_t inDataSize);
extern size_t EstimateBas64DecodedDataSize(size_t inDataSize);

extern bool Base64EncodeData(const void *inInputData, size_t inInputDataSize, char *outOutputData, size_t *ioOutputDataSize);
extern bool Base64DecodeData(const void *inInputData, size_t inInputDataSize, void *ioOutputData, size_t *ioOutputDataSize);

