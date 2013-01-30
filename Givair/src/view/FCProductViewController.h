//
//  FCProductViewController.h
//  Givair
//
//  Created by Peter Tsoi on 11/25/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FCCatalog.h"

@class FCImageView;
@class FCProduct;

@interface FCProductViewController : UIViewController <FCCatalogDelegate> {
    FCProduct * mProduct;

    FCImageView * mIconView;
    UILabel * mTitleLabel;
    UILabel * mVendorLabel;
    UILabel * mDescrLabel;

    UIButton * mWishListButton;
    UIButton * mBuyButton;

    UIButton * mSmallButton;
    UIButton * mMediumButton;
    UIButton * mLargeButton;

    int mSelectedSize;
}

- (id)initWithProduct:(FCProduct *)product;

@end
