//
//  FCCarouselBannerView.h
//  Givair
//
//  Created by Peter Tsoi on 11/24/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FCCarouselObject.h"

#define CAROUSEL_BANNER_WIDTH  320.0f
#define CAROUSEL_BANNER_HEIGHT 130.0f

@interface FCCarouselBannerView : UIControl {
    id <FCCarouselObject> mObject;
}

- (id)initWithCarouselObject:(id<FCCarouselObject>)object;

@end