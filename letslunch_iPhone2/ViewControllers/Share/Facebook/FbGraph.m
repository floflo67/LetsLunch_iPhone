//
//  FbGraph.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 01/08/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "FbGraph.h"
#import "FbGraphFile.h"

#define FBGRAPH_REDIRECT_URL @"http://www.facebook.com/connect/login_success.html"

@implementation FbGraph

id shareid;

- (id)initWithFbClientID:fbcid {
	if (self = [super init]) {
		self.facebookClientID = fbcid;
		self.redirectUri = FBGRAPH_REDIRECT_URL;
	}
	return self;
}

+ (BOOL)StoreShareid:(id)ids
{
	shareid = ids;
    return YES;
}

- (FbGraphResponse*)doGraphGet:(NSString*)action withGetVars:(NSDictionary*)get_vars {
	
	NSString *url_string = [NSString stringWithFormat:@"https://graph.facebook.com/%@?", action];
	
	//tack on any get vars we have...
	if ( (get_vars != nil) && ([get_vars count] > 0) ) {
		
		NSEnumerator *enumerator = [get_vars keyEnumerator];
		NSString *key;
		NSString *value;
		while ((key = (NSString*)[enumerator nextObject])) {
			
			value = (NSString*)[get_vars objectForKey:key];
			url_string = [NSString stringWithFormat:@"%@%@=%@&", url_string, key, value];
			
		}//end while	
	}//end if
	
	if (self.accessToken != nil) {
		//now that any variables have been appended, let's attach the access token....
		url_string = [NSString stringWithFormat:@"%@access_token=%@", url_string, self.accessToken];
	}
	
	//encode the string
	url_string = [url_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	return [self doGraphGetWithUrlString:url_string];
}

- (FbGraphResponse*)doGraphGetWithUrlString:(NSString*)url_string {
	
	FbGraphResponse *return_value = [[FbGraphResponse alloc] init];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url_string]];
	
	NSError *err;
	NSURLResponse *resp;
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&err];
	
	if (resp != nil) {
		
		/**
		 * In the case we request a picture (avatar) the Graph API will return to us the actual image
		 * bits versus a url to the image.....
		 **/
		if ([resp.MIMEType isEqualToString:@"image/jpeg"]) {
			
			UIImage *image = [UIImage imageWithData:response];
			return_value.imageResponse = image;
			
		} else {
		    
			NSString *stringResponse = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
			return_value.htmlResponse = stringResponse;
            stringResponse = nil;
		}
		
	} else if (err != nil) {
		return_value.error = err;
	}
	
	return return_value;
	
}

- (FbGraphResponse*)doGraphPost:(NSString*)action withPostVars:(NSDictionary*)post_vars {
	
	FbGraphResponse *return_value = [[FbGraphResponse alloc] init];
	
	NSString *urlString = [NSString stringWithFormat:@"https://graph.facebook.com/%@", action];
	NSLog(@"url string %@",urlString);
	NSURL *url = [NSURL URLWithString:urlString];
	NSString *boundary = @"----1010101010";
	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	[request setHTTPMethod:@"POST"];
	[request addValue:contentType forHTTPHeaderField: @"Content-Type"];
	
	NSMutableData *body = [NSMutableData data];
	[body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSEnumerator *enumerator = [post_vars keyEnumerator];
	NSString *key;
	NSString *value;
	NSString *content_disposition;
	
	//loop through all our parameters 
	while ((key = (NSString*)[enumerator nextObject])) {
		if ([key isEqualToString:@"file"]) {
			FbGraphFile *upload_file = (FbGraphFile*)[post_vars objectForKey:key];
			[upload_file appendDataToBody:body];
		}
        else {
			value = (NSString*)[post_vars objectForKey:key];
			
			content_disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key];
			[body appendData:[content_disposition dataUsingEncoding:NSUTF8StringEncoding]];
			[body appendData:[value dataUsingEncoding:NSUTF8StringEncoding]];
			
		}
		
		[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
		
	}
	
	//add our access token
	[body appendData:[@"Content-Disposition: form-data; name=\"access_token\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[self.accessToken dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	
	//button up the request body
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[request setHTTPBody:body];
	[request addValue:[NSString stringWithFormat:@"%d", body.length] forHTTPHeaderField: @"Content-Length"];
	
	//quite a few lines of code to simply do the business of the HTTP connection....
    NSURLResponse *response;
    NSData *data_reply;
	NSError *err;
	
    data_reply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
	
	NSString *stringResponse = [[NSString alloc] initWithData:data_reply encoding:NSUTF8StringEncoding];
    return_value.htmlResponse = stringResponse;
    stringResponse = nil;
	
	return return_value;
}

@end