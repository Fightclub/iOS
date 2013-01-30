//
//  FCProductViewController.h
//  Givair
//
//  Created by Peter Tsoi on 11/25/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FCImageView;
@class FCProduct;

@interface FCProductViewController : UIViewController {
    FCProduct * mProduct;

    FCImageView * mIconView;
    UILabel * mTitleLabel;
    UILabel * mVendorLabel;
    UILabel * mDescrLabel;
}

- (id)initWithProduct:(FCProduct *)product;

@end
