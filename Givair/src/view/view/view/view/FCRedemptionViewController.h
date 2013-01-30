//
//  FCRedemptionViewController.h
//  Givair
//
//  Created by Peter Tsoi on 12/4/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCGraph.h"
#import "StyledPullableView.h"

@class FCGift;


@interface FCRedemptionViewController : UIViewController <FCGraphDelegate> {
    FCGift * mGift;
    FCGraph * mGraph;
    StyledPullableView *pullUpView;
    UILabel *pullUpLabel;
}

- (id)initWithGift:(FCGift*)gift;

@end
