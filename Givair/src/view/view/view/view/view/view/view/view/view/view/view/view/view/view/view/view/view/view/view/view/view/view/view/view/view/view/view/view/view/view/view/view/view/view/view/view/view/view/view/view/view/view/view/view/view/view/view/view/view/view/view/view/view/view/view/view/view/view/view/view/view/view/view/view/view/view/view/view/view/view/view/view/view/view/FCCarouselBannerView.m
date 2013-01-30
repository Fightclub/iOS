//
//  FCCarouselBannerView.m
//  Givair
//
//  Created by Peter Tsoi on 11/24/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCCarouselBannerView.h"

#import "FCCarouselObject.h"
#import "FCImageView.h"
#import "FCImage.h"

@implementation FCCarouselBannerView

@synthesize carouselObject = mObject;

- (id)initWithCarouselObject:(id<FCCarouselObject>)object {
    self = [super init];
    if (self) {
        mObject = object;
        FCImageView * image = [[FCImageView alloc] initWithFCImage:[mObject getBanner]
                                                           inFrame:CGRectMake(0, 0, CAROUSEL_BANNER_WIDTH, CAROUSEL_BANNER_HEIGHT)];
        [self setFrame:image.frame];
        [image setUserInteractionEnabled:NO];
        [self addSubview:image];
    }
    return self;
}

@end