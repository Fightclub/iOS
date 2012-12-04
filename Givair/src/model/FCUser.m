//
//  FCUser.m
//  Givair
//
//  Created by Peter Tsoi on 12/2/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCUser.h"

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

@end
