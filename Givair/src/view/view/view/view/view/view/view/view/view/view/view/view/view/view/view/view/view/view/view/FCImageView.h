//
//  FCImageView.h
//  Givair
//
//  Created by Peter Tsoi on 11/22/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FCImage.h"
#import "FCNetwork.h"

@interface FCImageView : UIView <FCConnectionDelegate> {
    FCImage * mImage;
    UIActivityIndicatorView * mSpinner;
}

- (id)initWithImage:(UIImage *)image;
- (id)initWithFCImage:(FCImage *)image inFrame:(CGRect)frame;
- (id)initWithURL:(NSURL *)url inFrame:(CGRect)frame;

@end
