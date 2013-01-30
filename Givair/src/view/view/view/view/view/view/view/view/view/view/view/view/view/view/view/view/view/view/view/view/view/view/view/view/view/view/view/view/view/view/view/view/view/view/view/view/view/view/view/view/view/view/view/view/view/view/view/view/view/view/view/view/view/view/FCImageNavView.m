//
//  FCImageNavView.m
//  Givair
//
//  Created by Peter Tsoi on 12/4/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "FCImageNavView.h"

@interface UILabel (FCExtentions)
- (void)sizeToFitFixedWidth:(CGFloat)fixedWidth;
@end

@implementation UILabel (FCExtentions)


- (void)sizeToFitFixedWidth:(CGFloat)fixedWidth
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, fixedWidth, 0);
    self.lineBreakMode = NSLineBreakByWordWrapping;
    self.numberOfLines = 0;
    [self sizeToFit];
}

@end

@implementation FCImageNavView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:CGRectMake(frame.origin.x, frame.origin.y,
                                  frame.size.width, 44.0f)];
        CAGradientLayer * gradient = [CAGradientLayer layer];
        gradient.frame = self.bounds;
        gradient.colors = [NSArray arrayWithObjects:
                           (id)[[[UIColor blackColor] colorWithAlphaComponent:1.0f] CGColor],
                           (id)[[[UIColor blackColor] colorWithAlphaComponent:0.4f] CGColor], nil];
        [self.layer insertSublayer:gradient atIndex:0];

        UIButton * doneButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - 60.0f, 0.0f, 50.0f, 30.0f)];
        [doneButton addTarget:self.superview action:@selector(doneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [doneButton setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.2]];
        [doneButton setTitle:@"Done" forState:UIControlStateNormal];
        [doneButton.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];

        doneButton.layer.cornerRadius = 4.0f;
        doneButton.layer.masksToBounds = YES;
        doneButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        doneButton.layer.borderWidth = 1.0f;

        mTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f,
                                                                doneButton.frame.origin.x - 10.0f,
                                                                15.0f)];
        [mTitleLabel setFont:[UIFont fontWithName:@"MyriadApple-Bold" size:17.0f]];
        [mTitleLabel setTextColor:[UIColor whiteColor]];
        [mTitleLabel setBackgroundColor:[UIColor clearColor]];

        mSubtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(mTitleLabel.frame.origin.x, mTitleLabel.frame.origin.y + mTitleLabel.frame.size.height + 3.0f,
                                                                   doneButton.frame.origin.x - 10.0f, 15.0f)];
        [mSubtitleLabel setFont:[UIFont fontWithName:@"MyriadApple-Semibold" size:12.0f]];
        [mSubtitleLabel setTextColor:[UIColor whiteColor]];
        [mSubtitleLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:mTitleLabel];
        [self addSubview:mSubtitleLabel];
        
        [self addSubview:doneButton];

        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(0.0f, self.frame.size.height-0.0f, frame.size.width, 1.0f);
        bottomBorder.backgroundColor = [UIColor colorWithWhite:0.8f
                                                        alpha:0.4f].CGColor;
        [self.layer addSublayer:bottomBorder];

    }
    return self;
}

- (void) setTitle:(NSString *)title {
    [mTitleLabel setText:title];
    [mTitleLabel sizeToFitFixedWidth:mTitleLabel.frame.size.width];
}

- (void) setSubtitle:(NSString *)subTitle {
    [mSubtitleLabel setText:subTitle];
    [mSubtitleLabel sizeToFitFixedWidth:mTitleLabel.frame.size.width];
}

@end
