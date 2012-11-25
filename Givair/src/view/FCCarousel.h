//
//  FCCarousel.h
//  Givair
//
//  Created by Peter Tsoi on 11/24/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FCCarouselObject.h"

typedef enum {
    FCCarouselStyleBanner,
    FCCarouselStyleIcons
} FCCarouselStyle;

@protocol FCCarouselDelegate

- (void)didSelectCarouselItem:(id)item;

@end

@interface FCCarousel : UIView <UIScrollViewDelegate> {
    NSArray * mObjects;
    NSArray * mViews;
    NSString * mTitle;
    FCCarouselStyle mStyle;
    UIScrollView * mScroller;

    UILabel * mTitleLabel;
    int mCurrentIndex;
    id<FCCarouselDelegate> mDelegate;
}

@property (nonatomic) id delegate;

- (id)initWithStyle:(FCCarouselStyle)style;
- (id)initWithStyle:(FCCarouselStyle)style andObjects:(NSArray*)objects;
- (void)resize;

- (void)setTitle:(NSString*)title;
- (void)setObjects:(NSArray*)objects;
- (int)count;

@end