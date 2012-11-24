//
//  FCProduct.m
//  Givair
//
//  Created by Peter Tsoi on 11/22/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCProduct.h"

#import "FCCatalog.h"
#import "FCImage.h"
#import "FCVendor.h"

@implementation FCProduct

@synthesize ID = mID;
@synthesize price = mPrice;
@synthesize name = mName;
@synthesize sku = mSKU;
@synthesize vendor = mVendor;

- (id)initWithID:(int)ID price:(float)price name:(NSString*)name description:(NSString*)description SKU:(NSString*)sku vendor:(FCVendor*)vendor iconImage:(NSURL *)iconURL{
    self = [super init];
    if (self) {
        mID = ID;
        mPrice = price;
        mName = name;
        mSKU = sku;
        mVendor = vendor;
        mIconImage = [[FCImage alloc] initWithURL:iconURL];
        [mVendor addProduct:self];
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

- (void)setPromoImage:(FCImage*)image {
    mPromoImage = image;
}

- (void)setIconImage:(FCImage*)image {
    mIconImage = image;
}

@end
