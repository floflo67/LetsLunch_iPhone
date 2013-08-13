//
//  DBFriendInviter.h
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 10/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "DBFriendInviter.h"

/**
 * A simple value object that stores a reference to an address book contact (an ABRecordID)
 * and the contact's associated importance score.
 */
@interface __DBContactScorePair()
@property (nonatomic, strong) NSString *contactName;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic) NSInteger contactID;
@end

@implementation __DBContactScorePair

+ (instancetype)pairWithContact:(ABRecordID)contact
{
    return [[__DBContactScorePair alloc] initWithContact:contact];
}

- (instancetype)initWithContact:(ABRecordID)contact
{
    self = [super init];
    if (self) {
        self.contactID = contact;
    }
    return self;
}

// Return a human-readable name for the contact.
// This is for debugging purposes only because it instantiates a new ABAddressBookRef
// with every call. To improve performance you should reuse a single ABAddressBookRef.
- (NSString*)contactName
{
    CFErrorRef error = nil;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    ABRecordRef record = ABAddressBookGetPersonWithRecordID(addressBook, self.contactID);
    
    NSString *compositeName = CFBridgingRelease(ABRecordCopyCompositeName(record));
    
    if (addressBook) {
        CFRelease(addressBook);
    }
    
    return compositeName;
}

- (NSString*)phoneNumber
{
    CFErrorRef error = nil;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    ABRecordRef record = ABAddressBookGetPersonWithRecordID(addressBook, self.contactID);
    
    NSArray *phone = (__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(ABRecordCopyValue(record, kABPersonPhoneProperty));
    NSString *phoneNumber;
    
    if([phone count] >0)
        phoneNumber = [phone objectAtIndex:0];
    else
        phoneNumber = nil;
    
    if (addressBook) {
        CFRelease(addressBook);
    }
    
    return phoneNumber;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@(%@, recordID=%i)", NSStringFromClass(self.class), self.contactName, self.contactID];
}

// Sort by descending score, i.e. higher scores first.
- (NSComparisonResult) compare:(__DBContactScorePair*)other
{
    return [[self contactName] compare:[other contactName]];
}

@end

/**
 * A simple value object that stores an adress book contact property (an ABPropertyID)
 * and its associated importance score. We use this to construct a static lookup table
 * for determining the importance score of an address book contact.
 *
 * This is an internal class used by the DBFriendFinder class and should not be
 * exposed externally.
 */
@interface __DBPropertyScorePair : NSObject
@property(readonly, nonatomic) ABPropertyID property;
+ (instancetype)pairWithProperty:(ABPropertyID)property;
- (instancetype)initWithProperty:(ABPropertyID)property;
@end

@implementation __DBPropertyScorePair

+ (instancetype) pairWithProperty:(ABPropertyID)property
{
    return [[__DBPropertyScorePair alloc] initWithProperty:property];
}

- (instancetype) initWithProperty:(ABPropertyID)property
{
    self = [super init];
    if (self) {
        _property = property;
    }
    return self;
}

@end

@implementation DBFriendInviter

+ (NSArray*) mostImportantContactsWithIgnoredRecordIDs:(NSSet*)ignoredRecordIDs maxResults:(NSUInteger)maxResults
{
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    if (!addressBook) {
        return nil;        
    }
    
    // Compute an importance score for all contacts in the address book
    // (except for those blacklisted by the `ignoredRecordIDs` set).
    NSArray *allPeople = CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(addressBook));
    NSMutableArray *mostImportantContacts = [NSMutableArray arrayWithCapacity:[allPeople count]];
    for (NSInteger personIndex = 0; personIndex < allPeople.count; personIndex++) {
        ABRecordRef person = (__bridge ABRecordRef) [allPeople objectAtIndex:personIndex];
        ABRecordID personID = ABRecordGetRecordID(person);
        
        if ([ignoredRecordIDs containsObject:@(personID)]) {
            continue;
        }
        __DBContactScorePair *record = [__DBContactScorePair pairWithContact:personID];
        if(![record phoneNumber])
            continue;
        
        [mostImportantContacts addObject:record];
    }
    
    if (addressBook) {
        CFRelease(addressBook);
    }
    
    [mostImportantContacts sortUsingSelector:@selector(compare:)];
    /*
    // Convert the results into a list of ABRecordIDs wrapped in NSNumbers.
    // Also limit the number of results to `maxResults`.
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:maxResults];
    NSRange resultsRange = NSMakeRange(0, MIN(maxResults, mostImportantContacts.count));
    for (__DBContactScorePair *pair in [mostImportantContacts subarrayWithRange:resultsRange]) {
        [results addObject:@(pair.contact)];
    }
    */
    return mostImportantContacts;
}

+ (NSArray*) mostImportantContacts
{
    return [self mostImportantContactsWithIgnoredRecordIDs:nil maxResults:50];
}

@end
