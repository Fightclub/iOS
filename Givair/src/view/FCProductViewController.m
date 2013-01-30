//
//  FCProductViewController.m
//  Givair
//
//  Created by Peter Tsoi on 11/25/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "FCProductViewController.h"

#import "FCAppDelegate.h"
#import "FCImageView.h"
#import "FCProduct.h"
#import "FCVendor.h"
#import "FCFriendSelectViewController.h"

#define ICON_VIEW_WIDTH  70.0f
#define ICON_VIEW_HEIGHT 70.0f

@interface UILabel (FCExtentions)
- (void)sizeToFitFixedWidth:(CGFloat)fixedWidth;
@end

@implementation UILabel (FCExtentions)


- (void)sizeToFitFixedWidth:(CGFloat)fixedWidth
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, fixedWidth, 0);
    self.lineBreakMode = NSLineBreakByWordWrapping;
    self.numberOfLines = 0;
    [self sizeToFit];
}

@end

@interface FCProductViewController ()

@end

@implementation FCProductViewController

- (id)initWithProduct:(FCProduct *)product{
    self = [super init];
    if (self) {
        mProduct = product;
        if (!AppDelegate.catalog) {
            AppDelegate.catalog = [[FCCatalog alloc] initWithDelegate:self];
        } else {
            [AppDelegate.catalog registerForDelegateCallback:self];
        }
        [AppDelegate.catalog downloadProductWithID:mProduct.ID];
        self.title = @"Info";

        UIScrollView * content = [[UIScrollView alloc] initWithFrame:self.view.frame];
        [content setAlwaysBounceVertical:YES];
        self.view = content;

        mSelectedSize = 1;
        
        [self.view setBackgroundColor:[UIColor colorWithWhite:0.9216f alpha:1.0f]];

        mIconView = [[FCImageView alloc] initWithFCImage:[mProduct getIcon]
                                                 inFrame:CGRectMake(10.0, 10.0f,
                                                                    ICON_VIEW_WIDTH, ICON_VIEW_HEIGHT)];
        mIconView.layer.cornerRadius = 8.0f;
        mIconView.layer.masksToBounds = YES;
        mIconView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        mIconView.layer.borderWidth = 0.4f;

        [self.view addSubview:mIconView];

        mTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(mIconView.frame.origin.x + mIconView.frame.size.width + 8.0f, mIconView.frame.origin.y,
                                                                self.view.frame.size.width - (mIconView.frame.origin.x + 16.0f + mIconView.frame.size.width),
                                                                15.0f)];
        [mTitleLabel setFont:[UIFont fontWithName:@"MyriadApple-Bold" size:17.0f]];
        [mTitleLabel setTextColor:[UIColor colorWithWhite:0.3f alpha:1.0f]];
        [mTitleLabel setBackgroundColor:[UIColor clearColor]];
        [mTitleLabel setShadowColor:[UIColor whiteColor]];
        [mTitleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
        [mTitleLabel setText:mProduct.name];
        [mTitleLabel sizeToFitFixedWidth:mTitleLabel.frame.size.width];
        [self.view addSubview:mTitleLabel];

        mVendorLabel = [[UILabel alloc] initWithFrame:CGRectMake(mTitleLabel.frame.origin.x, mTitleLabel.frame.origin.y + mTitleLabel.frame.size.height,
                                                                 mTitleLabel.frame.size.width, 15.0f)];
        [mVendorLabel setFont:[UIFont fontWithName:@"MyriadApple-Semibold" size:12.0f]];
        [mVendorLabel setTextColor:[UIColor colorWithWhite:0.5f alpha:1.0f]];
        [mVendorLabel setBackgroundColor:[UIColor clearColor]];
        [mVendorLabel setShadowColor:[UIColor whiteColor]];
        [mVendorLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
        [mVendorLabel setText:mProduct.vendor.name];
        [self.view addSubview:mVendorLabel];

        mDescrLabel = [[UILabel alloc] initWithFrame:CGRectMake(mIconView.frame.origin.x, mIconView.frame.origin.y + mIconView.frame.size.height + 10.0f,
                                                                self.view.frame.size.width - mIconView.frame.origin.x, 70.0f)];
        [mDescrLabel setFont:[UIFont fontWithName:@"MyriadApple-Semibold" size:12.0f]];
        [mDescrLabel setTextColor:[UIColor colorWithWhite:0.3f alpha:1.0f]];
        [mDescrLabel setBackgroundColor:[UIColor clearColor]];
        [mDescrLabel setShadowColor:[UIColor whiteColor]];
        [mDescrLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
        [mDescrLabel setNumberOfLines:5];
        [mDescrLabel setText:mProduct.description];
        CGRect descrRect = [mDescrLabel textRectForBounds:mDescrLabel.bounds limitedToNumberOfLines:999];
        CGRect f = mDescrLabel.frame;
        f.size.height = descrRect.size.height;
        mDescrLabel.frame = f;
        
        [self.view addSubview:mDescrLabel];

        if ([mProduct.vendor.name isEqualToString:@"Starbucks"]) {
            mWishListButton = [[UIButton alloc] initWithFrame:CGRectMake(mIconView.frame.origin.x, self.view.frame.size.height - 32 - 142,
                                                                         self.view.frame.size.width - mIconView.frame.origin.x * 2, 32)];
            mBuyButton = [[UIButton alloc] initWithFrame:CGRectMake(mIconView.frame.origin.x, self.view.frame.size.height - 32 - 102,
                                                                    self.view.frame.size.width - mIconView.frame.origin.x * 2, 32)];

            [mWishListButton setBackgroundImage:[[UIImage imageNamed:@"graybutton.png"]
                                               resizableImageWithCapInsets:UIEdgeInsetsMake(3.0f, 3.0f, 3.0f, 3.0f)]
                                     forState:UIControlStateNormal];

            [mBuyButton setBackgroundImage:[[UIImage imageNamed:@"bluebutton.png"]
                                               resizableImageWithCapInsets:UIEdgeInsetsMake(3.0f, 3.0f, 3.0f, 3.0f)]
                                     forState:UIControlStateNormal];

            [mWishListButton setTitle:@"Add to Wishlist" forState:UIControlStateNormal];
            [mBuyButton setTitle:@"Send to a Friend" forState:UIControlStateNormal];

            [mWishListButton.titleLabel setFont:[UIFont fontWithName:@"MyriadApple-Bold" size:16.0f]];
            [mWishListButton.titleLabel setShadowColor:[UIColor grayColor]];
            [mWishListButton.titleLabel setShadowOffset:CGSizeMake(0.0, -1.0)];

            [mBuyButton.titleLabel setFont:[UIFont fontWithName:@"MyriadApple-Bold" size:16.0f]];
            [mBuyButton.titleLabel setShadowColor:[UIColor grayColor]];
            [mBuyButton.titleLabel setShadowOffset:CGSizeMake(0.0, -1.0)];
            [mBuyButton addTarget:self action:@selector(sendButtonPushed:) forControlEvents:UIControlEventTouchUpInside];

            [self.view addSubview:mWishListButton];
            [self.view addSubview:mBuyButton];

            mSmallButton = [[UIButton alloc] initWithFrame: CGRectMake(30, self.view.frame.size.height - 210 - 65, 50, 65)];
            [mSmallButton setImage:[UIImage imageNamed:@"smallcup_gray.png"] forState:UIControlStateNormal];
            [mSmallButton addTarget:self action:@selector(selectedSize:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:mSmallButton];

            mMediumButton = [[UIButton alloc] initWithFrame: CGRectMake(120, self.view.frame.size.height - 210 - 85, 65, 85)];
            [mMediumButton setImage:[UIImage imageNamed:@"medcup_green.png"] forState:UIControlStateNormal];
            [mMediumButton addTarget:self action:@selector(selectedSize:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:mMediumButton];

            mLargeButton = [[UIButton alloc] initWithFrame: CGRectMake(225, self.view.frame.size.height - 210 - 101, 78, 101)];
            [mLargeButton setImage:[UIImage imageNamed:@"lrgcup_gray.png"] forState:UIControlStateNormal];
            [mLargeButton addTarget:self action:@selector(selectedSize:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:mLargeButton];
        }
    }
    return self;
}

- (void)catalogFinishedUpdating {
    [mTitleLabel setText:mProduct.name];
    [mVendorLabel setText:mProduct.vendor.name];
    [mDescrLabel setFrame:CGRectMake(mDescrLabel.frame.origin.x, mDescrLabel.frame.origin.y,
                                     self.view.frame.size.width - mDescrLabel.frame.origin.x * 2, 70.0f)];
    [mDescrLabel setText:mProduct.description];
    CGRect descrRect = [mDescrLabel textRectForBounds:mDescrLabel.bounds limitedToNumberOfLines:999];
    CGRect f = mDescrLabel.frame;
    f.size.height = descrRect.size.height;
    mDescrLabel.frame = f;
}

- (void)selectedSize:(id)sender {
    if (sender == mSmallButton) {
        mSelectedSize = 0;
        [mSmallButton setImage:[UIImage imageNamed:@"smallcup_green.png"] forState:UIControlStateNormal];
        [mMediumButton setImage:[UIImage imageNamed:@"medcup_gray.png"] forState:UIControlStateNormal];
        [mLargeButton setImage:[UIImage imageNamed:@"lrgcup_gray.png"] forState:UIControlStateNormal];
    } else if (sender == mMediumButton) {
        mSelectedSize = 1;
        [mSmallButton setImage:[UIImage imageNamed:@"smallcup_gray.png"] forState:UIControlStateNormal];
        [mMediumButton setImage:[UIImage imageNamed:@"medcup_green.png"] forState:UIControlStateNormal];
        [mLargeButton setImage:[UIImage imageNamed:@"lrgcup_gray.png"] forState:UIControlStateNormal];
    } else if (sender == mLargeButton) {
        mSelectedSize = 2;
        [mSmallButton setImage:[UIImage imageNamed:@"smallcup_gray.png"] forState:UIControlStateNormal];
        [mMediumButton setImage:[UIImage imageNamed:@"medcup_gray.png"] forState:UIControlStateNormal];
        [mLargeButton setImage:[UIImage imageNamed:@"lrgcup_green.png"] forState:UIControlStateNormal];
    }
}

- (void)sendButtonPushed:(id)sender {
    FCFriendSelectViewController * selection = [[FCFriendSelectViewController alloc] initWithGift:mProduct];
    [self.navigationController pushViewController:selection animated:YES];
}

@end
