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

- (id) initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (BOOL) loaded {
    return self.CGImage || self.CIImage;
}

@end
