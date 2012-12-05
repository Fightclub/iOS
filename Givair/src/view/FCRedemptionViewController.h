//
//  FCRedemptionViewController.h
//  Givair
//
//  Created by Peter Tsoi on 12/4/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FCGift;

@interface FCRedemptionViewController : UIViewController {
    FCGift * mGift;
}

- (id)initWithGift:(FCGift*)gift;

@end
