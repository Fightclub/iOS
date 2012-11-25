//
//  FCImageView.m
//  Givair
//
//  Created by Peter Tsoi on 11/22/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCImageView.h"

#import "FCAppDelegate.h"
#import "FCNetwork.h"

@implementation FCImageView

- (id)initWithImage:(UIImage *)image {
    self = [self initWithFrame:CGRectMake(0.0f, 0.0f, image.size.width, image.size.height)];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithPatternImage:image]];
    }
    return self;
}

- (id)initWithFCImage:(FCImage *)image inFrame:(CGRect)frame{
    if (image.loaded) {
        self = [self initWithImage:(UIImage *)[FCImage imageWithImage:image scaledToSize:frame.size]];
        self.frame = frame;
    } else {
        self = [self initWithURL:image.url inFrame:frame];
    }

    if (self) {
        mImage = image;
    }
    return self;
}

- (id)initWithURL:(NSURL *)url inFrame:(CGRect)frame {
    self = [self initWithFrame:frame];
    if (self) {
        mSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        mSpinner.center = self.center;
        [mSpinner startAnimating];
        [self addSubview:mSpinner];
        [AppDelegate.network dataAtURL:url delegate:self];
    }
    return self;
}

#pragma mark - FCConnectionDelegate

- (void)connection:(FCConnection *)connection finishedDownloadingData:(NSData *)data {
    [mSpinner stopAnimating];
    FCImage * image = [[FCImage alloc] initWithData:data];
    mImage = [FCImage imageWithImage:image scaledToSize:self.frame.size];
    [self setBackgroundColor:[UIColor colorWithPatternImage:mImage]];
}

- (void)connection:(FCConnection *)connection failedWithError:(NSError *)error {
    [mSpinner stopAnimating];
    NSLog(@"Image load error: %@", error);
}

@end
