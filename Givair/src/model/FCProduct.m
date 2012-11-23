//
//  FCProduct.m
//  Givair
//
//  Created by Peter Tsoi on 11/22/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCProduct.h"

@implementation FCProduct

- (id)initWithName:(NSString*)name SKU:(NSString*)sku vendor:(FCVendor*)vendor {
    self = [super init];
    if (self) {
        mName = name;
        mSKU = sku;
        mVendor = vendor;
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
    return mPromoImage;
}

- (void)setPromoImage:(UIImage*)image {
    
}

- (void)setIconImage:(UIImage*)image {

}

@end
