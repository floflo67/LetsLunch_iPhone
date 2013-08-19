//
//  Contacts.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 24/06/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "Contacts.h"

@interface Contacts()
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *firstname;
@property (nonatomic, strong) NSString *lastname;
@property (nonatomic, strong) NSString *jobTitle;
@property (nonatomic, strong) NSString *pictureURL;
@property (nonatomic, strong) NSMutableArray *listMessages;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic) BOOL onWishlist;
@end

@implementation Contacts

#pragma mark - initialization

- (id)initWithDictionary:(NSDictionary*)dict
{
    self = [self init];
    if(self) {
        self.ID = [dict objectForKey:@"uid"];
        self.firstname = [dict objectForKey:@"firstname"];
        if(!self.firstname)
            self.firstname = @"";
        
        self.lastname = [dict objectForKey:@"lastname"];
        if(!self.lastname || [self.lastname.class isSubclassOfClass:[NSNull class]])
            self.lastname = @"";
        
        self.onWishlist = [[dict objectForKey:@"onWishList"] boolValue];
        
        self.jobTitle = [dict objectForKey:@"headline"];
        if(!self.jobTitle || [self.jobTitle.class isSubclassOfClass:[NSNull class]])
            self.jobTitle = @"";
        
        self.pictureURL = [dict objectForKey:@"pictureURL"];
        if(!self.pictureURL || [self.pictureURL.class isSubclassOfClass:[NSNull class]] || [self.pictureURL isEqualToString:@""]) {
            self.pictureURL = LL_Default_Picture_Url;
            self.image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.pictureURL]]];
        }
    }
    return self;
}

- (id)initWithID:(NSString*)ID firstname:(NSString*)firstname lastname:(NSString*)lastname jobTitle:(NSString*)jobTitle onWishlist:(BOOL)onWishlist andPictureURL:(NSString*)url
{
    self = [self init];
    if(self) {
        self.ID = ID;
        self.firstname = firstname;
        self.lastname = lastname;
        self.jobTitle = jobTitle;
        self.onWishlist = onWishlist;
        self.pictureURL = url;
        if(!self.pictureURL || [self.pictureURL.class isSubclassOfClass:[NSNull class]] || [self.pictureURL isEqualToString:@""]) {
            self.pictureURL = LL_Default_Picture_Url;
            self.image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.pictureURL]]];
        }
    }
    return self;
}

#pragma mark - setter

- (void)setMessages:(NSArray*)list
{
    NSArray *sortedArray = [list sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSDate *first = [(Messages*)a date];
        NSDate *second = [(Messages*)b date];
        return [first compare:second];
    }];
    self.listMessages = (NSMutableArray*)sortedArray;
}

-(void)setImage:(UIImage*)image
{
    _image = image;
}

@end
