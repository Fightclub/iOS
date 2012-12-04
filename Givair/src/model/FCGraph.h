//
//  FCGraph.h
//  Givair
//
//  Created by Peter Tsoi on 12/3/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FCNetwork.h"

@class FCUser;

@protocol FCGraphDelegate

- (void)graphFinishedUpdating;

@end

@interface FCGraph : NSObject <FCConnectionDelegate> {
    NSMutableDictionary * mUsers;
    NSMutableDictionary * mGifts;

    NSMutableArray * mDelegates;
    CFMutableDictionaryRef mActiveConnections;
}

- (id) initWithDelegate:(id<FCGraphDelegate>)delegate;

- (void)downloadUserInfoWithID:(int)ID;
- (FCUser *)getUserWithID:(int)ID;
- (BOOL)updating;

@end
