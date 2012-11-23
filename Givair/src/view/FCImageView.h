//
//  FCImageView.h
//  Givair
//
//  Created by Peter Tsoi on 11/22/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCImage.h"

@interface FCImageView : UIView <FCImageLoaderDelegate> {
    FCImage * mImage;
}

- (id)initWithImage:(UIImage *)image;
- (id)initWithFCImage:(FCImage *)image;
- (id)initWithURL:(NSURL *)url;

@end
