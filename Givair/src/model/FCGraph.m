//
//  FCGraph.m
//  Givair
//
//  Created by Peter Tsoi on 12/3/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCGraph.h"

#import "FCAppDelegate.h"
#import "FCCatalog.h"
#import "FCGift.h"
#import "FCProduct.h"
#import "FCUser.h"
#import "FCVendor.h"

@implementation FCGraph

typedef enum {
    kFCGraphNetworkTaskDownloadUserInfo,
    kFCGraphNetworkTaskDownloadUserGifts,
    kFCGraphNetworkTaskSendGift,
} kFCGraphNetworkTask;

- (id) init {
    self = [super init];
    if (self) {
        mGifts = [[NSMutableDictionary alloc] init];
        mUsers = [[NSMutableDictionary alloc] init];
        mActiveConnections = CFDictionaryCreateMutable(kCFAllocatorDefault,
                                                       0,
                                                       &kCFTypeDictionaryKeyCallBacks,
                                                       &kCFTypeDictionaryValueCallBacks);
        mDelegates = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id) initWithDelegate:(id<FCGraphDelegate>)delegate {
    self = [self init];
    if (self) {
        mDelegates = [[NSMutableArray alloc] initWithObjects:delegate, nil];
    }
    return self;
}

- (void)registerForDelegateCallback:(id<FCGraphDelegate>)delegate {
    [mDelegates addObject:delegate];
}

- (void)unregisterForDelegateCallback:(id<FCGraphDelegate>)delegate {
    [mDelegates removeObject:delegate];
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

- (void)downloadGiftsForUserWithKey:(NSString*)key {
    FCConnection * conn = [AppDelegate.network dataAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"network/a/user/gifts?apikey=%@", key]
                                                                relativeToURL:[NSURL URLWithString:@"http://fight-club-alpha.herokuapp.com"]] delegate:self];
    CFDictionaryAddValue(mActiveConnections,
                         (__bridge const void *)conn,
                         (__bridge const void *)[NSString stringWithFormat:@"%i",kFCGraphNetworkTaskDownloadUserGifts]);
}

- (void)addGift:(FCGift *)newGift {
    if (![mGifts objectForKey:[NSString stringWithFormat:@"%i", newGift.ID]])
        [mGifts setValue:newGift forKey:[NSString stringWithFormat:@"%i", newGift.ID]];
}

- (FCGift *)giftFromListInfo:(NSDictionary *)info {
    FCGift * newGift = [self getGiftWithID:[[info objectForKey:@"id"] intValue]];
    if (!newGift) {
        NSDictionary * productInfo = [info objectForKey:@"product"];
        NSDictionary * vendorInfo = [productInfo objectForKey:@"vendor"];
        NSDictionary * senderInfo = [info objectForKey:@"sender"];
        NSDictionary * receiverInfo = [productInfo objectForKey:@"receiver"];
        FCProduct * newProduct = [AppDelegate.catalog getProductWithID:[[productInfo objectForKey:@"id"] intValue]];
        if (!newProduct) {
            FCVendor * newVendor = [AppDelegate.catalog getVendorWithID:[[vendorInfo objectForKey:@"id"] intValue]];
            if (!newVendor) {
                newVendor = [[FCVendor alloc] initWithID:[[vendorInfo objectForKey:@"id"] intValue]
                                                    name:[vendorInfo objectForKey:@"name"]
                                               iconImage:[vendorInfo objectForKey:@"icon"]];
                [AppDelegate.catalog addVendor:newVendor];
            }
            newProduct = [[FCProduct alloc] initWithID:[[productInfo objectForKey:@"id"] intValue]
                                                 price:0.0f
                                                  name:[productInfo objectForKey:@"name"]
                                           description:nil
                                                   SKU:nil
                                                vendor:newVendor
                                             iconImage:[productInfo objectForKey:@"icon"]
                                           bannerImage:nil];
            [AppDelegate.catalog addProduct:newProduct];
        }
        FCUser * sender = [AppDelegate.graph getUserWithID:[[senderInfo objectForKey:@"id"] intValue]];
        if (!sender) {
            sender = [[FCUser alloc] initWithID:[[senderInfo objectForKey:@"id"] intValue]
                                          Email:[senderInfo objectForKey:@"email"]
                                          first:[senderInfo objectForKey:@"first"]
                                           last:[senderInfo objectForKey:@"last"]
                                         APIKey:nil FBEmail:nil];
            [AppDelegate.graph addUser:sender];
        }
        FCUser * receiver = [AppDelegate.graph getUserWithID:[[senderInfo objectForKey:@"id"] intValue]];
        if (!receiver) {
            receiver = [[FCUser alloc] initWithID:[[receiverInfo objectForKey:@"id"] intValue]
                                            Email:[receiverInfo objectForKey:@"email"]
                                            first:[receiverInfo objectForKey:@"first"]
                                             last:[receiverInfo objectForKey:@"last"]
                                           APIKey:nil FBEmail:nil];
            [AppDelegate.graph addUser:receiver];
        }
        newGift = [[FCGift alloc] initWithID:[[info objectForKey:@"id"] intValue]
                                      sender:sender
                                    receiver:receiver
                                     product:newProduct
                                      status:kFCGiftStatusCreated
                                     created:nil
                                   activated:nil
                                    redeemed:nil];
    }
    return newGift;
}

- (void)sendNewGift:(FCProduct*)gift fromUser:(NSString*)apiKey toUser:(NSString*)recieverEmail {
    FCConnection * conn = [AppDelegate.network dataAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"network/a/gift/new?apikey=%@&product=%i&email=%@", apiKey, gift.ID, recieverEmail]
                                                                relativeToURL:[NSURL URLWithString:@"http://fight-club-alpha.herokuapp.com"]] delegate:self];
    CFDictionaryAddValue(mActiveConnections,
                         (__bridge const void *)conn,
                         (__bridge const void *)[NSString stringWithFormat:@"%i",kFCGraphNetworkTaskSendGift]);
}

- (void)downloadedUserGiftList:(NSDictionary*)info {
    NSArray * received = [info objectForKey:@"received"];
    NSArray * sent = [info objectForKey:@"sent"];
    if (sent && received) {
        FCUser * newUser = [self getUserWithID:[[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] intValue]];
        for (NSDictionary * sentInfo in sent) {
            FCGift * newGift = [self giftFromListInfo:sentInfo];
            [self addGift:newGift];
            [newUser addSentGift:newGift];
        }
        for (NSDictionary * receivedInfo in received) {
            FCGift * newGift = [self giftFromListInfo:receivedInfo];
            [self addGift:newGift];
            [newUser addReceivedGift:newGift];
        }
    }
}

- (FCGift *) getGiftWithID:(int)ID {
    return [mGifts objectForKey:[NSString stringWithFormat:@"%i", ID]];
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
            case kFCGraphNetworkTaskDownloadUserGifts:
                [self downloadedUserGiftList:info];
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
