//
//  FCImageView.m
//  Givair
//
//  Created by Peter Tsoi on 11/22/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCImageView.h"

@implementation FCImageView

- (id)initWithImage:(UIImage *)image {
    self = [self initWithFrame:CGRectMake(0.0f, 0.0f, image.size.width, image.size.height)];
    if (self) {
        
    }
    return self;
}

- (id)initWithFCImage:(FCImage *)image {
    if (image.loaded)
        self = [self initWithImage:(UIImage *)image];
    else
        self = [self init];

    if (self) {
        mImage = image;
    }
    return self;
}

- (id)initWithURL:(NSURL *)url {
    self = [self init];
    if (self) {

    }
    return self;
}

#pragma mark - FCImageLoaderDelegate

- (void)imageHasLoaded:(FCImage *)image {

}

- (void)imageCouldNotLoad:(NSError *)error {
    
}

@end
