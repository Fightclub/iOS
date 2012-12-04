//
//  FCUser.m
//  Givair
//
//  Created by Peter Tsoi on 12/2/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCUser.h"

#import "FCGift.h"

@implementation FCUser

@synthesize ID = mID;
@synthesize first = mFirst;
@synthesize last = mLast;
@synthesize birthday = mBirthday;

- (id)initWithID:(int)ID Email:(NSString*)email first:(NSString*)first last:(NSString*)last APIKey:(NSString*)key FBEmail:(NSString*)fbemail {
    self = [super init];
    if (self) {
        mID = ID;
        mEmail = email;
        mFirst = first;
        mLast = last;
        mAPIKey = key;
        mFBEmail = fbemail;
    }
    return self;
}

- (void)addSentGift:(FCGift*)gift {
    if (![mSentGifts objectForKey:[NSString stringWithFormat:@"%i", gift.ID]]) {
        [mSentGifts setObject:gift forKey:[NSString stringWithFormat:@"%i", gift.ID]];
    }
}

- (void)addReceivedGift:(FCGift*)gift {
    if (![mReceivedGifts objectForKey:[NSString stringWithFormat:@"%i", gift.ID]]) {
        [mReceivedGifts setObject:gift forKey:[NSString stringWithFormat:@"%i", gift.ID]];
    }
}
 
- (NSArray*)getSentGifts {
    return [mSentGifts allValues];
}

- (NSArray*)getReceivedGifts {
    return [mReceivedGifts allValues];
}

@end
