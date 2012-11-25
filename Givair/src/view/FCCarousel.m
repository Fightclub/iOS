//
//  FCCarousel.m
//  Givair
//
//  Created by Peter Tsoi on 11/24/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCCarousel.h"

#import "FCCarouselObject.h"
#import "FCCarouselBannerView.h"
#import "FCCarouselIconView.h"

@implementation FCCarousel

- (id)init {
    self = [super init];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
        mObjects = [[NSArray alloc] init];
    }
    return self;
}

- (id)initWithStyle:(FCCarouselStyle)style {
    self = [self init];
    if (self) {
        mStyle = style;
        mScroller = [[UIScrollView alloc] init];
        [mScroller setAlwaysBounceHorizontal:YES];
        [mScroller setShowsHorizontalScrollIndicator:NO];
        if (mStyle == FCCarouselStyleBanner) {
            [mScroller setFrame:CGRectMake(0, 0,
                                           CAROUSEL_BANNER_WIDTH, CAROUSEL_BANNER_HEIGHT)];
        } else if (mStyle == FCCarouselStyleIcons) {
            [mScroller setFrame:CGRectMake(0, CAROUSEL_BANNER_HEIGHT-CAROUSEL_ICON_HEIGHT,
                                           CAROUSEL_BANNER_WIDTH, CAROUSEL_ICON_HEIGHT)];
        }
        [self addSubview:mScroller];
    }
    return self;
}

- (id)initWithStyle:(FCCarouselStyle)style andObjects:(NSArray*)objects {
    self = [self initWithStyle:style];
    if (self) {
        [self setObjects:objects];
    }
    return self;
}

- (void)resize {
    if (mStyle == FCCarouselStyleBanner) {
        self.frame = mScroller.frame;
    } else if (mStyle == FCCarouselStyleIcons) {
        [mScroller setFrame:CGRectMake(0, 0, CAROUSEL_BANNER_WIDTH, CAROUSEL_BANNER_HEIGHT)];
    }
}

- (void)setTitle:(NSString*)title {
    mTitle = title;
    if (mStyle == FCCarouselStyleIcons) {
        // Add title to view
    }
}

- (int)count {
    return [mObjects count];
}

- (void)setObjects:(NSArray*)objects {
    mObjects = objects;
    mViews = nil;
    [self setupObjects];
}

- (void)setupObjects {
    NSMutableArray * constructedViews = [NSMutableArray arrayWithCapacity:[mObjects count]];
    int i = 0;
    for (id <FCCarouselObject> object in mObjects) {
        if (mStyle == FCCarouselStyleBanner) {
            FCCarouselBannerView * banner = [[FCCarouselBannerView alloc] initWithCarouselObject:object];
            [constructedViews addObject:banner];
            [self addCarouselView:banner atIndex:i];
        } else if (mStyle == FCCarouselStyleIcons) {
            FCCarouselIconView * icon = [[FCCarouselIconView alloc] initWithCarouselObject:object];
            [constructedViews addObject:icon];
            [self addCarouselView:icon atIndex:i];
        }
        i++;
    }
    mViews = [constructedViews mutableCopy];
    if (mStyle == FCCarouselStyleBanner) {
        [mScroller setContentSize:CGSizeMake(CAROUSEL_BANNER_WIDTH * [mViews count], CAROUSEL_BANNER_HEIGHT)];
    } else if (mStyle == FCCarouselStyleIcons) {
        [mScroller setContentSize:CGSizeMake(CAROUSEL_ICON_WIDTH * [mViews count], CAROUSEL_ICON_HEIGHT)];
    }
}

- (void)addCarouselView:(UIView*)view atIndex:(int)index {
    if (mStyle == FCCarouselStyleBanner) {
        view.frame = CGRectMake(CAROUSEL_BANNER_WIDTH * index, view.frame.origin.y,
                                view.frame.size.width, view.frame.size.height);
    } else if (mStyle == FCCarouselStyleIcons) {
        view.frame = CGRectMake(CAROUSEL_ICON_WIDTH * index, view.frame.origin.y,
                                view.frame.size.width, view.frame.size.height);
    }
    [mScroller addSubview:view];
}

@end
