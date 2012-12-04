//
//  FCGift.m
//  Givair
//
//  Created by Peter Tsoi on 12/3/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCGift.h"

#import "FCUser.h"

@implementation FCGift

@synthesize ID = mID;
@synthesize product = mProduct;

- (id) initWithID:(int)ID
           sender:(FCUser*)sender
         receiver:(FCUser*)receiver
          product:(FCProduct*)product
           status:(FCGiftStatus)status
          created:(NSDate*)created
        activated:(NSDate*)activated
         redeemed:(NSDate*)redeemed {
    self = [super init];
    if (self) {
        mID = ID;
        mSender = sender;
        mReceiver = receiver;
        mProduct = product;
        mStatus = status;
        mCreated = created;
        mActivated = activated;
        mRedeemed = redeemed;
    }
    return self;
}

@end
