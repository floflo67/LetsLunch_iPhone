//
//  KeychainWrapper.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 10/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

@interface KeychainWrapper : NSObject {
    NSMutableDictionary *keychainData;
    NSMutableDictionary *genericPasswordQuery;
}

@property (nonatomic, strong) NSMutableDictionary *keychainData;
@property (nonatomic, strong) NSMutableDictionary *genericPasswordQuery;

-(id)initWithIdentifier:(NSString*)identifier accessGroup:(NSString*)accessGroup;
-(void)mySetObject:(id)inObject forKey:(id)key;
-(id)myObjectForKey:(id)key;
-(void)resetKeychainItem;

@end
