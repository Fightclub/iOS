//
//  FCRedemptionViewController.m
//  Givair
//
//  Created by Peter Tsoi on 12/4/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCRedemptionViewController.h"

#import "FCGift.h"
#import "FCImageNavView.h"
#import "FCImageView.h"
#import "FCProduct.h"
#import "FCUser.h"

@interface FCRedemptionViewController ()

@end

@implementation FCRedemptionViewController

- (id)initWithGift:(FCGift*)gift {
    self = [super init];
    if (self) {
        mGift = gift;
        FCImageView * background = [[FCImageView alloc] initWithFCImage:[gift.product getIcon] inFrame:self.view.frame];
        FCImageNavView * navView = [[FCImageNavView alloc] initWithFrame:background.frame];
        [navView setTitle:gift.product.name];
        [navView setSubtitle:[NSString stringWithFormat:@"from %@ %@", gift.sender.first, gift.sender.last]];
        [self.view addSubview:background];
        [self.view addSubview:navView];
    }
    return self;
}

- (void)doneButtonPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
