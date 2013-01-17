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

@end
