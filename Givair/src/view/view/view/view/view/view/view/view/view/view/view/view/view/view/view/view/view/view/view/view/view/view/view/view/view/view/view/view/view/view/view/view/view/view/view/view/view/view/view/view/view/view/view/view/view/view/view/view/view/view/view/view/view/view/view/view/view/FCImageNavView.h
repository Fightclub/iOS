//
//  FCImageNavView.h
//  Givair
//
//  Created by Peter Tsoi on 12/4/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCImageNavView : UIView {
    UIButton * mDoneButton;
    UILabel * mTitleLabel;
    UILabel * mSubtitleLabel;
}

- (void) setTitle:(NSString *)title;
- (void) setSubtitle:(NSString *)subTitle;

@end
