//
//  FCImage.h
//  Givair
//
//  Created by Peter Tsoi on 11/22/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FCImage;

@protocol FCImageLoaderDelegate

- (void)imageHasLoaded:(FCImage *)image;
- (void)imageCouldNotLoad:(NSError *)error;

@end

@interface FCImage : UIImage <NSURLConnectionDelegate> {
    NSURL * mRemotePath;
    BOOL mLoaded;
}

@property (nonatomic, readonly) BOOL loaded;

- (id) initWithURL:(NSURL *)url;

@end
