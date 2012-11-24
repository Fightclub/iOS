//
//  FCCarouselIconView.m
//  Givair
//
//  Created by Peter Tsoi on 11/24/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCCarouselIconView.h"

#import "FCImageView.h"
#import "FCImage.h"

#define ICON_VIEW_WIDTH  64.0f
#define ICON_VIEW_HEIGHT 64.0f

@implementation FCCarouselIconView

- (id)initWithCarouselObject:(id<FCCarouselObject>)object {
    self = [super initWithFrame:CGRectMake(0.0, 0.0, CAROUSEL_ICON_WIDTH, CAROUSEL_ICON_HEIGHT)];
    if (self) {
        mObject = object;
        FCImageView * iconView = [[FCImageView alloc] initWithImage:[mObject getIcon]];
        [iconView setFrame:CGRectMake((CAROUSEL_ICON_WIDTH-ICON_VIEW_WIDTH)/2, 0.0f, ICON_VIEW_WIDTH, ICON_VIEW_HEIGHT)];
        [self addSubview:iconView];

        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

@end