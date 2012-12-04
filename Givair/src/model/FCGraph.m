//
//  FCGraph.m
//  Givair
//
//  Created by Peter Tsoi on 12/3/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCGraph.h"

#import "FCAppDelegate.h"
#import "FCUser.h"

@implementation FCGraph

typedef enum {
    kFCGraphNetworkTaskDownloadUserInfo,
} kFCGraphNetworkTask;

- (id) initWithDelegate:(id<FCGraphDelegate>)delegate {
    self = [super init];
    if (self) {
        mGifts = [[NSMutableDictionary alloc] init];
        mUsers = [[NSMutableDictionary alloc] init];
        mActiveConnections = CFDictionaryCreateMutable(kCFAllocatorDefault,
                                                       0,
                                                       &kCFTypeDictionaryKeyCallBacks,
                                                       &kCFTypeDictionaryValueCallBacks);
        mDelegates = [[NSMutableArray alloc] initWithObjects:delegate, nil];
    }
    return self;
}

- (void)downloadUserInfoWithID:(int)ID {
    FCConnection * conn = [AppDelegate.network dataAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"network/a/user?id=%i", ID]
                                                                relativeToURL:[NSURL URLWithString:@"http://fight-club-alpha.herokuapp.com"]] delegate:self];
    CFDictionaryAddValue(mActiveConnections,
                         (__bridge const void *)conn,
                         (__bridge const void *)[NSString stringWithFormat:@"%i",kFCGraphNetworkTaskDownloadUserInfo]);
}

- (void)addUser:(FCUser *)newUser {
    if (![mUsers objectForKey:[NSString stringWithFormat:@"%i", newUser.ID]])
        [mUsers setValue:newUser forKey:[NSString stringWithFormat:@"%i", newUser.ID]];
}

- (FCUser *)downloadedUserInfo:(NSDictionary*)info {
    FCUser * newUser;
    if ([info objectForKey:@"id"]) {
        newUser = [self getUserWithID:[[info objectForKey:@"id"] intValue]];
        if (!newUser) {
            newUser = [[FCUser alloc] initWithID:[[info objectForKey:@"id"] intValue]
                                           Email:[info objectForKey:@"email"]
                                           first:[info objectForKey:@"first"]
                                            last:[info objectForKey:@"last"]
                                          APIKey:[info objectForKey:@"apikey"]
                                         FBEmail:[info objectForKey:@"fbemail"]];
            [self addUser:newUser];
        }
    }
    return newUser;
}

- (FCUser *)getUserWithID:(int)ID {
    return [mUsers objectForKey:[NSString stringWithFormat:@"%i", ID]];
}

- (BOOL)updating {
    return CFDictionaryGetCount(mActiveConnections) > 0;
}

#pragma mark - FCConnectionDelegate

- (void) connection:(FCConnection *)connection finishedDownloadingData:(NSData *)data {
    if (CFDictionaryContainsKey(mActiveConnections, (__bridge const void *)connection)) {
        NSString * mode = CFDictionaryGetValue(mActiveConnections, (__bridge const void *)connection);
        NSMutableDictionary * info = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:nil];
        switch ([mode intValue]) {
            case kFCGraphNetworkTaskDownloadUserInfo:
                [self downloadedUserInfo:info];
                break;

            default:
                break;
        }
        CFDictionaryRemoveValue(mActiveConnections, (__bridge const void *)connection);
    }
    if (![self updating]) {
        for (id<FCGraphDelegate> delegate in mDelegates) {
            [delegate graphFinishedUpdating];
        }
    }
}

- (void) connection:(FCConnection *)connection failedWithError:(NSError *)error {
    if (CFDictionaryContainsKey(mActiveConnections, (__bridge const void *)connection))
        CFDictionaryRemoveValue(mActiveConnections, (__bridge const void *)connection);
    if (![self updating]) {
        for (id<FCGraphDelegate> delegate in mDelegates) {
            [delegate graphFinishedUpdating];
        }
    }
}

@end
