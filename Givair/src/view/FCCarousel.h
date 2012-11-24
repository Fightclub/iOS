//
//  FCCarousel.h
//  Givair
//
//  Created by Peter Tsoi on 11/24/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    FCCarouselStyleBanner,
    FCCarouselStyleIcons
} FCCarouselStyle;

@interface FCCarousel : UIView {
    NSArray * mObjects;
    NSArray * mViews;
    NSString * mTitle;
    FCCarouselStyle mStyle;
    UIScrollView * mScroller;
}

- (id)initWithStyle:(FCCarouselStyle)style;
- (id)initWithStyle:(FCCarouselStyle)style andObjects:(NSArray*)objects;
- (void)resize;

- (void)setObjects:(NSArray*)objects;

@end