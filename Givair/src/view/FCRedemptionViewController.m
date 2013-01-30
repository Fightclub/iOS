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
        [AppDelegate.graph registerForDelegateCallback:self];
        [mGraph redeemGiftsForUserWithKey:[[NSUserDefaults standardUserDefaults] objectForKey:@"apikey"] GiftID:gift.ID];
        
        FCImageView * background = [[FCImageView alloc] initWithFCImage:[gift.product getIcon] inFrame:self.view.frame];
        FCImageNavView * navView = [[FCImageNavView alloc] initWithFrame:background.frame];
        [navView setSubtitle:[NSString stringWithFormat:@"from %@ %@", gift.sender.first, gift.sender.last]];
        [self.view addSubview:background];
        [self.view addSubview:navView];
        [navView setTitle:gift.product.name];
        
        
        //Pullable view
        CGFloat xOffset = 0;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            xOffset = 224;
        }
        pullUpView = [[StyledPullableView alloc] initWithFrame:CGRectMake(xOffset, 0, 320, 460)];
        pullUpView.openedCenter = CGPointMake(160 + xOffset,self.view.frame.size.height + 100);
        pullUpView.closedCenter = CGPointMake(160 + xOffset, self.view.frame.size.height + 200);
        pullUpView.center = pullUpView.closedCenter;
        pullUpView.handleView.frame = CGRectMake(0, 0, 320, 40);
        pullUpView.delegate = self;
        
        [self.view addSubview:pullUpView];
        //[pullUpView release];
        
        pullUpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 4, 320, 20)];
        pullUpLabel.textAlignment = UITextAlignmentCenter;
        pullUpLabel.backgroundColor = [UIColor clearColor];
        pullUpLabel.textColor = [UIColor lightGrayColor];
        pullUpLabel.text = @"Pull up to redeem";
        
        [pullUpView addSubview:pullUpLabel];
        //[pullUpLabel release];
        /*
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 320, 64)];
        label.textAlignment = UITextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.shadowColor = [UIColor blackColor];
        label.shadowOffset = CGSizeMake(1, 1);
        label.text = @"I only go half-way up!";
        
        [pullUpView addSubview:label];
         */
        //[label release];
        
        
        
        if (gift.barcodeUrlString != nil) {
            [self showBarcode];

        }

    }
    return self;
}

- (void)doneButtonPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)graphFinishedUpdating {
    [self showBarcode];
}

- (void)showBarcode {
    FCImage * barcode = [[FCImage alloc] initWithURL:[NSURL URLWithString:mGift.barcodeUrlString]];
    FCImageView * barcodeView = [[FCImageView alloc] initWithFCImage:barcode inFrame:CGRectMake(40, 40, 240, 60)];
    
    [pullUpView addSubview:barcodeView];
    //[self.view addSubview:barcodeView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (void)pullableView:(PullableView *)pView didChangeState:(BOOL)opened {
    if (opened) {
        //[self showBarcode];
        pullUpLabel.text = @"Redeemed!";
    } else {
        pullUpLabel.text = @"Pull up to redeem";
    }
}


@end
