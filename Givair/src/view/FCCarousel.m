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
        mCurrentIndex = 0;
    }
    return self;
}

- (id)initWithStyle:(FCCarouselStyle)style {
    self = [self init];
    if (self) {
        mStyle = style;
        mScroller = [[UIScrollView alloc] init];
        mScroller.delegate = self;
        [mScroller setShowsHorizontalScrollIndicator:NO];
        [mScroller setAlwaysBounceHorizontal:YES];
        [mScroller setBackgroundColor:[UIColor clearColor]];
        if (mStyle == FCCarouselStyleBanner) {
            [mScroller setFrame:CGRectMake(0, 0,
                                           CAROUSEL_BANNER_WIDTH, CAROUSEL_BANNER_HEIGHT)];
        } else if (mStyle == FCCarouselStyleIcons) {
            [mScroller setFrame:CGRectMake(0, CAROUSEL_ICON_TITLE_HEIGHT,
                                           CAROUSEL_BANNER_WIDTH, CAROUSEL_ICON_HEIGHT)];
            mTitleLabel = [[UILabel alloc] init];
            [mTitleLabel setFont:[UIFont fontWithName:@"MyriadApple-Bold" size:18.0f]];
            [mTitleLabel setShadowColor:[UIColor whiteColor]];
            [mTitleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
            [mTitleLabel setTextColor:[UIColor colorWithWhite:0.37f alpha:1.0f]];
            [mTitleLabel setBackgroundColor:[UIColor clearColor]];
            mTitleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
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
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
                                mScroller.frame.size.width, mScroller.frame.size.height);
    } else if (mStyle == FCCarouselStyleIcons) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
                                CAROUSEL_BANNER_WIDTH, CAROUSEL_BANNER_HEIGHT);
        [mTitleLabel setFrame:CGRectMake(10.0f, 0.0f, self.frame.size.width-50, 30)];
    }
}

- (void)setTitle:(NSString*)title {
    mTitle = title;
    if (mStyle == FCCarouselStyleIcons) {
        mTitleLabel.text = mTitle;
        [self addSubview:mTitleLabel];
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

- (void)scrollToIndex:(int)index animated:(BOOL)animated {
    if (mStyle == FCCarouselStyleBanner) {
        if (index < 0)
            index = 0;
        else if (index >= [self count])
            index = [self count]-1;
        [mScroller scrollRectToVisible:CGRectMake(index*CAROUSEL_BANNER_WIDTH, 0.0, mScroller.frame.size.width, mScroller.frame.size.height) animated:animated];
        mCurrentIndex = index;
    } else if (mStyle == FCCarouselStyleIcons) {
        [mScroller scrollRectToVisible:CGRectMake(index*CAROUSEL_ICON_WIDTH, 0.0, mScroller.frame.size.width, mScroller.frame.size.height) animated:animated];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGPoint offset = scrollView.contentOffset;
    if (mStyle == FCCarouselStyleBanner) {
        *targetContentOffset = offset;
        if (velocity.x > 0.5) {
            [self scrollToIndex:mCurrentIndex+1 animated:YES];
        } else if (velocity.x < -0.5) {
            [self scrollToIndex:mCurrentIndex-1 animated:YES];
        } else {
            [self scrollToIndex:(int)round(offset.x/CAROUSEL_BANNER_WIDTH) animated:YES];
        }
    } else if (mStyle == FCCarouselStyleIcons) {

    }
}

@end
