//
//  OAAttachment.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "OAAttachment.h"

@implementation OAAttachment

@synthesize name, filename, contentType, data;

- (id)initWithName:(NSString *)aName filename:(NSString *)aFilename contentType:(NSString *)aContentType data:(NSData *)aData{
	self = [super init];
	if(self){
		self.name = aName;
		self.filename = aFilename;
		self.contentType = aContentType;
		self.data = aData;
	}
	return self;
}

- (void)dealloc{
	[name release];
	[filename release];
	[contentType release];
	[data release];
	[super dealloc];
}

@end