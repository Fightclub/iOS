//
//  FCIconCell.h
//  Givair
//
//  Created by Peter Tsoi on 11/25/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FCImageView.h"

@class FCImage;
@class FCImageView;

@interface FCIconCell : UITableViewCell {
    FCImageView * mIcon;
    IBOutlet UILabel * mTitleLabel;
    IBOutlet UILabel * mSubtitleLabel;
}

- (void)setTitle:(NSString*)title;
- (void)setSubtitle:(NSString*)subtitle;
- (void)setIconImage:(FCImage*)icon;

@end
