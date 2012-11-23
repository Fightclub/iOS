//
//  FCImage.h
//  Givair
//
//  Created by Peter Tsoi on 11/22/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FCNetwork.h"

@class FCImage;

@protocol FCImageLoaderDelegate

- (void)imageHasLoaded:(FCImage *)image;
- (void)imageCouldNotLoad:(NSError *)error;

@end

@interface FCImage : UIImage {
    NSURL * mURL;
    BOOL mLoaded;
}

@property (nonatomic, readonly) BOOL loaded;
@property (nonatomic, readonly) NSURL * url;

- (id) initWithURL:(NSURL *)url;
+ (FCImage *) imageWithImage:(FCImage *)image scaledToSize:(CGSize)newSize;

@end
