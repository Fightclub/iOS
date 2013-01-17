//
//  FCGift.h
//  Givair
//
//  Created by Peter Tsoi on 12/3/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FCUser;
@class FCProduct;

typedef enum {
    kFCGiftStatusCreated,
    kFCGiftStatusActive,
    kFCGiftStatusRedeemed,
} FCGiftStatus;

@interface FCGift : NSObject {
    int mID;
    FCUser * mReceiver;
    FCUser * mSender;
    FCProduct * mProduct;
    FCGiftStatus mStatus;
    NSDate * mCreated;
    NSDate * mActivated;
    NSDate * mRedeemed;
}

@property (nonatomic, readonly) int ID;
@property (nonatomic, readonly) FCUser * receiver;
@property (nonatomic, readonly) FCUser * sender;
@property (nonatomic, readonly) FCProduct * product;

- (id) initWithID:(int)ID
           sender:(FCUser*)sender
         receiver:(FCUser*)receiver
          product:(FCProduct*)product
           status:(FCGiftStatus)status
          created:(NSDate*)created
        activated:(NSDate*)activated
         redeemed:(NSDate*)redeemed;

@end
