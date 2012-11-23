//
//  FCProduct.h
//  Givair
//
//  Created by Peter Tsoi on 11/22/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FCImage;
@class FCVendor;

@interface FCProduct : NSObject {
    NSString * mName;
    NSString * mSKU;
    FCVendor * mVendor;

    FCImage * mPromoImage;
    FCImage * mIconImage;
}

- (id)initWithName:(NSString*)name SKU:(NSString*)sku vendor:(FCVendor*)vendor;
- (void)setPromoImage:(FCImage*)image;
- (void)setIconImage:(FCImage*)image;

@end
