//
//  FbGraphFile.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/08/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "FbGraphFile.h"

@implementation FbGraphFile

- (id)initWithImage:(UIImage*)upload_image {
	
	if (self = [super init]) {
		self.uploadImage = upload_image;
	}
	return self;
}

/**
 * this way the class is easily extensible to other file
 * types as FB allows us to upload them into the graph...
 * with little if any modification to the code 
**/
- (void)appendDataToBody:(NSMutableData*)body {
	
	/**
	 * Facebook Graph API only support images at the moment, surely videos must occur soon.
	 **/
	
	NSData *picture_data = UIImagePNGRepresentation(self.uploadImage);
	[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"media\";\r\nfilename=\"media.png\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:picture_data];
}

@end
