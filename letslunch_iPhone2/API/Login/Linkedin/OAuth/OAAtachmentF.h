//
//  OAAttachment.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OAAttachment : NSObject {
	NSString *name;
	NSString *fileName;
	NSString *contentType;
	NSData *data;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *contentType;
@property (nonatomic, copy) NSData *data;

- (id)initWithName:(NSString *)aName filename:(NSString *)aFilename contentType:(NSString *)aContentType data:(NSData *)aData;

@end