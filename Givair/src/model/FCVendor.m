//
//  FCVendor.m
//  Givair
//
//  Created by Peter Tsoi on 11/23/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCVendor.h"

@implementation FCVendor

- (id)initWithName:(NSString*)name {
    self = [super init];
    if (self) {
        mName = name;
    }
    return self;
}

- (NSString*)getName {
    return mName;
}

- (NSString*)getDescription {
    return @"Description";
}

- (FCImage*)getIcon {
    return mIconImage;
}

- (FCImage*)getBanner {
    return mBannerImage;
}

- (void)setIconImage:(FCImage*)image {
    mIconImage = image;
}

@end
