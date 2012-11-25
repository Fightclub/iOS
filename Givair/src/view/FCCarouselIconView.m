//
//  FCCarouselIconView.m
//  Givair
//
//  Created by Peter Tsoi on 11/24/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "FCCarouselIconView.h"

#import "FCImageView.h"
#import "FCImage.h"

#define ICON_VIEW_WIDTH  70.0f
#define ICON_VIEW_HEIGHT 70.0f

@implementation FCCarouselIconView

- (id)initWithCarouselObject:(id<FCCarouselObject>)object {
    self = [super initWithFrame:CGRectMake(0.0, 0.0, CAROUSEL_ICON_WIDTH, CAROUSEL_ICON_HEIGHT)];
    if (self) {
        mObject = object;
        FCImageView * iconView = [[FCImageView alloc] initWithFCImage:[mObject getIcon]
                                                              inFrame:CGRectMake((CAROUSEL_ICON_WIDTH-ICON_VIEW_WIDTH)/2, 0.0f,
                                                                                 ICON_VIEW_WIDTH, ICON_VIEW_HEIGHT)];
        [iconView setUserInteractionEnabled:NO];
        iconView.layer.cornerRadius = 8.0f;
        iconView.layer.masksToBounds = YES;
        iconView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        iconView.layer.borderWidth = 0.4f;

        [self addSubview:iconView];

        UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconView.frame.origin.x, iconView.frame.origin.y + iconView.frame.size.height + 2.0f,
                                                                        ICON_VIEW_WIDTH, 15.0f)];
        [nameLabel setFont:[UIFont fontWithName:@"MyriadApple-Bold" size:12.0f]];
        [nameLabel setTextColor:[UIColor colorWithWhite:0.3f alpha:1.0f]];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setShadowColor:[UIColor whiteColor]];
        [nameLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
        [nameLabel setText:[object getName]];
        [self addSubview:nameLabel];

        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

@end