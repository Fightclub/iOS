//
//  FCImage.m
//  Givair
//
//  Created by Peter Tsoi on 11/22/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCImage.h"

@implementation FCImage

@synthesize loaded = mLoaded;
@synthesize url = mURL;

- (id) initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        mURL = url;
    }
    return self;
}

- (BOOL) loaded {
    return self.CGImage || self.CIImage;
}

+ (FCImage *) imageWithImage:(FCImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    FCImage *newImage = (FCImage *)UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
