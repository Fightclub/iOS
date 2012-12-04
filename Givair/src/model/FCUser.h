//
//  FCUser.h
//  Givair
//
//  Created by Peter Tsoi on 12/2/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCUser : NSObject {
    int mID;
    NSString * mEmail;
    NSString * mFirst;
    NSString * mLast;
    NSString * mAPIKey;
    NSString * mFBEmail;

    NSDate * mBirthday;
}

@property (nonatomic, readonly) int ID;
@property (nonatomic, readonly) NSString * first;
@property (nonatomic, readonly) NSString * last;
@property (nonatomic, readonly) NSDate * birthday;

- (id)initWithID:(int)ID Email:(NSString*)email first:(NSString*)first last:(NSString*)last APIKey:(NSString*)key FBEmail:(NSString*)fbemail;

@end
