//
//  FCIconCell.m
//  Givair
//
//  Created by Peter Tsoi on 11/25/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "FCIconCell.h"

#import "FCImageView.h"

@implementation FCIconCell

- (void)awakeFromNib {
    [mTitleLabel setFont:[UIFont fontWithName:@"MyriadApple-Bold" size:17.0f]];
    [mTitleLabel setTextColor:[UIColor colorWithWhite:0.3f alpha:1.0f]];
    [mTitleLabel setBackgroundColor:[UIColor clearColor]];
    [mTitleLabel setShadowColor:[UIColor whiteColor]];
    [mTitleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];

    [mSubtitleLabel setFont:[UIFont fontWithName:@"MyriadApple-Semibold" size:13.0f]];
    [mSubtitleLabel setTextColor:[UIColor colorWithWhite:0.5f alpha:1.0f]];
    [mSubtitleLabel setBackgroundColor:[UIColor clearColor]];
    [mSubtitleLabel setShadowColor:[UIColor whiteColor]];
    [mSubtitleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
}


- (void)setTitle:(NSString*)title {
    [mTitleLabel setText:title];
}
- (void)setSubtitle:(NSString*)subtitle {
    [mSubtitleLabel setText:subtitle];
}

- (void)setIconImage:(FCImage*)icon {
    mIcon = [[FCImageView alloc] initWithFCImage:icon
                                         inFrame:CGRectMake(8.0f, 8.0f,
                                                            70.0f, 70.0f)];
    mIcon.layer.cornerRadius = 8.0f;
    mIcon.layer.masksToBounds = YES;
    mIcon.layer.borderColor = [UIColor lightGrayColor].CGColor;
    mIcon.layer.borderWidth = 0.4f;

    [self addSubview:mIcon];
}

@end
