//
//  FCRedemptionViewController.m
//  Givair
//
//  Created by Peter Tsoi on 12/4/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCRedemptionViewController.h"

#import "FCAppDelegate.h"
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
        
        mGraph = AppDelegate.graph;
        [mGraph redeemGiftsForUserWithKey:[[NSUserDefaults standardUserDefaults] objectForKey:@"apikey"] GiftID:gift.ID];
        
        FCImageView * background = [[FCImageView alloc] initWithFCImage:[gift.product getIcon] inFrame:self.view.frame];
        FCImageNavView * navView = [[FCImageNavView alloc] initWithFrame:background.frame];
        
        if (gift.barcodeUrlString != nil) {
            // Barcode redemption
            FCImage * barcode = [[FCImage alloc] initWithURL:[NSURL URLWithString:gift.barcodeUrlString]];
            FCImageView * barcodeView = [[FCImageView alloc] initWithFCImage:barcode inFrame:background.frame];
            [self.view addSubview:barcodeView];
            [navView setTitle:gift.product.name];
        } else {
            NSLog(@"Barcode not generated");
            [navView setTitle:@"Barcode Not Generated"];
        }
        


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
