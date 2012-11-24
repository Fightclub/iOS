//
//  FCCarouselBannerView.m
//  Givair
//
//  Created by Peter Tsoi on 11/24/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCCarouselBannerView.h"

#import "FCImageView.h"

@implementation FCCarouselBannerView

- (id)initWithCarouselObject:(id<FCCarouselObject>)object {
    self = [super init];
    if (self) {
        mObject = object;
        FCImageView * image = [[FCImageView alloc] initWithImage:[mObject getBanner]];
        [image setFrame:CGRectMake(0, 0, CAROUSEL_BANNER_WIDTH, CAROUSEL_BANNER_HEIGHT)];
        [self addSubview:image];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end