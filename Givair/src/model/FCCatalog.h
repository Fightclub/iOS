//
//  FCCatalog.h
//  Givair
//
//  Created by Peter Tsoi on 11/23/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FCNetwork.h"

@class FCProduct;
@class FCProductCategory;
@class FCVendor;

@protocol FCCatalogDelegate

- (void)catalogFinishedUpdating;

@end

@interface FCCatalog : NSObject <FCConnectionDelegate> {
    NSMutableDictionary * mProducts;
    NSMutableDictionary * mProductCategories;
    NSMutableDictionary * mVendors;

    CFMutableDictionaryRef mActiveConnections;

    id<FCCatalogDelegate> mDelegate;
}

- (id) initWithDelegate:(id<FCCatalogDelegate>)delegate;

- (void)addProduct:(FCProduct *)product;
- (void)addVendor:(FCVendor *)vendor;
- (void)downloadProductWithID:(int)ID;
- (FCProduct *)getProductWithID:(int)ID;
- (FCProductCategory *)getProductCategoryWithID:(int)ID;
- (FCVendor *)getVendorWithID:(int)ID;
- (BOOL)updating;

@end
