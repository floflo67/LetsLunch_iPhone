//
//  TwitterUtils.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#include <CommonCrypto/CommonHMAC.h>

#import "TwitterUtils.h"

@implementation TwitterUtils

static const char sBase64Digits[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

+ (NSString*) encodeData: (NSData*) data
{
   if (data == nil) {
      return nil;
   }
   
   NSUInteger dataLength = [data length];
   const UInt8* dataBytePtr = [data bytes];

   NSUInteger encodedLength = (dataLength / 3) * 4;
   if ((dataLength % 3) != 0) {
      encodedLength += 4;
   }

   NSMutableString* string = [NSMutableString stringWithCapacity: encodedLength];
   
   char buffer[5];
   
   while (dataLength >= 3)
   {
      buffer[0] = sBase64Digits[dataBytePtr[0] >> 2];
      buffer[1] = sBase64Digits[((dataBytePtr[0] << 4) & 0x30) | (dataBytePtr[1] >> 4)];
      buffer[2] = sBase64Digits[((dataBytePtr[1] << 2) & 0x3c) | (dataBytePtr[2] >> 6)];
      buffer[3] = sBase64Digits[dataBytePtr[2] & 0x3f];
      buffer[4] = 0x00;

      [string appendString: [NSString stringWithCString: buffer encoding: NSASCIIStringEncoding]];
      
      dataBytePtr += 3;
      dataLength -= 3;
   }

   if (dataLength > 0)
   {
      char fragment = (dataBytePtr[0] << 4) & 0x30;
      if (dataLength > 1) {
         fragment |= dataBytePtr[1] >> 4;
      }
      
      buffer[0] = sBase64Digits[dataBytePtr[0] >> 2];
      buffer[1] = sBase64Digits[(int) fragment];
      buffer[2] = (dataLength < 2) ? '=' : sBase64Digits[(dataBytePtr[1] << 2) & 0x3c];
      buffer[3] = '=';
      buffer[4] = 0x00;
      
      [string appendString: [NSString stringWithCString: buffer encoding: NSASCIIStringEncoding]];
   }

   return string;
}

+ (NSData*) generateSignatureOverString: (NSString*) string withSecret: (NSData*) secret
{
	CCHmacContext context;
	CCHmacInit(&context, kCCHmacAlgSHA1, [secret bytes], [secret length]);	
	
	NSData* data = [string dataUsingEncoding: NSASCIIStringEncoding];
	CCHmacUpdate(&context, [data bytes], [data length]);

	unsigned char digestBytes[CC_SHA1_DIGEST_LENGTH];
	CCHmacFinal(&context, digestBytes);
	
	return [NSData dataWithBytes: digestBytes length: CC_SHA1_DIGEST_LENGTH];
}

@end
