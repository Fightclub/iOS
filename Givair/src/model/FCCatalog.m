//
//  FCCatalog.m
//  Givair
//
//  Created by Peter Tsoi on 11/23/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCCatalog.h"

#import "FCAppDelegate.h"
#import "FCProduct.h"
#import "FCProductCategory.h"
#import "FCVendor.h"

typedef enum {
    kFCCatalogNetworkTaskCatalogDownload,
    kFCCatalogNetworkTaskProductDownload,
    kFCCatalogNetworkTaskVendorDownload,
} kFCCatalogNetworkTask;

@implementation FCCatalog

- (id) initWithDelegate:(id<FCCatalogDelegate>)delegate {
    self = [super init];
    if (self) {
        mProducts = [[NSMutableDictionary alloc] init];
        mProductCategories = [[NSMutableDictionary alloc] init];
        mVendors = [[NSMutableDictionary alloc] init];
        mActiveConnections = CFDictionaryCreateMutable(kCFAllocatorDefault,
                                                       0,
                                                       &kCFTypeDictionaryKeyCallBacks,
                                                       &kCFTypeDictionaryValueCallBacks);
        mDelegate = delegate;
        [self downloadCatalog];
    }
    return self;
}

- (void)addProduct:(FCProduct *)product {
    [mProducts setValue:product forKey:[NSString stringWithFormat:@"%i", product.ID]];
}

- (void)addVendor:(FCVendor *)vendor {
    [mVendors setValue:vendor forKey:[NSString stringWithFormat:@"%i", vendor.ID]];
}

- (void)addProductCategory:(FCProductCategory *)category {
    [mProductCategories setValue:category forKey:[NSString stringWithFormat:@"%i", category.ID]];
}

- (void)downloadCatalog {
    FCConnection * conn = [AppDelegate.network dataAtURL:[NSURL URLWithString:@"catalog/a"
                                                                relativeToURL:[NSURL URLWithString:@"http://fight-club-beta.herokuapp.com"]] delegate:self];
    CFDictionaryAddValue(mActiveConnections,
                         (__bridge const void *)conn,
                         (__bridge const void *)[NSString stringWithFormat:@"%i",kFCCatalogNetworkTaskCatalogDownload]);

}

- (void)downloadProductWithID:(int)ID {
    FCConnection * conn = [AppDelegate.network dataAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"catalog/a/product?id=%i", ID]
                                                                relativeToURL:[NSURL URLWithString:@"http://fight-club-beta.herokuapp.com"]] delegate:self];
    CFDictionaryAddValue(mActiveConnections,
                         (__bridge const void *)conn,
                         (__bridge const void *)[NSString stringWithFormat:@"%i",kFCCatalogNetworkTaskProductDownload]);

}

- (FCProduct *)getProductWithID:(int)ID {
    return [mProducts objectForKey:[NSString stringWithFormat:@"%i", ID]];
}

- (FCProductCategory *)getProductCategoryWithID:(int)ID {
    return [mProductCategories objectForKey:[NSString stringWithFormat:@"%i", ID]];
}

- (FCVendor *)getVendorWithID:(int)ID {
    return [mVendors objectForKey:[NSString stringWithFormat:@"%i", ID]];
}

#pragma mark - Network Callbacks

- (void)downloadedCatalogInfo:(NSDictionary *)info {
    NSMutableArray * categoryInfos = [info objectForKey:@"categories"];
    NSMutableArray * vendorInfos = [info objectForKey:@"vendors"];
    if (categoryInfos && vendorInfos) {
        for (NSDictionary * categoryInfo in categoryInfos) {
            FCProductCategory * category = [self getProductCategoryWithID:[[categoryInfo objectForKey:@"id"] intValue]];
            if (! category) {
                category = [[FCProductCategory alloc] initWithID:[[categoryInfo objectForKey:@"id"] intValue]
                                                            name:[categoryInfo objectForKey:@"name"]
                                                       iconImage:[NSURL URLWithString:[categoryInfo objectForKey:@"icon"]]];
            }
            [self addProductCategory:category];
        }
        for (NSDictionary * vendorInfo in vendorInfos) {
            FCVendor * vendor = [self getVendorWithID:[[vendorInfo objectForKey:@"id"] intValue]];
            if (! vendor) {
                vendor = [[FCVendor alloc] initWithID:[[vendorInfo objectForKey:@"id"] intValue]
                                                 name:[vendorInfo objectForKey:@"name"]
                                            iconImage:[NSURL URLWithString:[vendorInfo objectForKey:@"icon"]]];
            }
            [self addVendor:vendor];
        }
    }
}

- (void)downloadedProductInfo:(NSDictionary *)info {
    if (![self getProductWithID:[[info objectForKey:@"id"] intValue]]) {
        NSDictionary * vendorInfo = [info objectForKey:@"vendor"];
        NSMutableArray * categoryInfos = [info objectForKey:@"categories"];
        if (vendorInfo) {
            FCVendor * vendor = [self getVendorWithID:[[vendorInfo objectForKey:@"id"] intValue]];
            if (!vendor) {
                FCVendor * newVendor = [[FCVendor alloc] initWithID:[[vendorInfo objectForKey:@"id"] intValue]
                                                               name:[vendorInfo objectForKey:@"name"]
                                                          iconImage:[NSURL URLWithString:[vendorInfo objectForKey:@"icon"]]];
                [self addVendor:newVendor];
            }
            FCProduct * newProduct = [[FCProduct alloc] initWithID:[[info objectForKey:@"id"] intValue]
                                                             price:[[info objectForKey:@"price"] floatValue]
                                                              name:[info objectForKey:@"name"]
                                                       description:[info objectForKey:@"description"]
                                                               SKU:[info objectForKey:@"sku"]
                                                            vendor:vendor
                                                         iconImage:[NSURL URLWithString:[info objectForKey:@"icon"]]];
            [self addProduct:newProduct];
            for (NSDictionary * categoryInfo in categoryInfos) {
                FCProductCategory * category = [self getProductCategoryWithID:[[categoryInfo objectForKey:@"id"] intValue]];
                if (! category) {
                    category = [[FCProductCategory alloc] initWithID:[[categoryInfo objectForKey:@"id"] intValue]
                                                                name:[categoryInfo objectForKey:@"name"]
                                                           iconImage:[NSURL URLWithString:[categoryInfo objectForKey:@"icon"]]];
                    [self addProductCategory:category];
                }

                [category addProduct:newProduct];
            }
        }
    }
}

- (BOOL)updating{
    return CFDictionaryGetCount(mActiveConnections) > 0;
}


#pragma mark - FCConnectionDelegate

- (void)connection:(FCConnection *)connection finishedDownloadingData:(NSData *)data {
    if (CFDictionaryContainsKey(mActiveConnections, (__bridge const void *)connection)) {
        NSString * mode = CFDictionaryGetValue(mActiveConnections, (__bridge const void *)connection);
        NSMutableDictionary * info = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:nil];
        switch ([mode intValue]) {
            case kFCCatalogNetworkTaskCatalogDownload:
                [self downloadedCatalogInfo:info];
                break;
            case kFCCatalogNetworkTaskProductDownload:
                [self downloadedProductInfo:info];
                break;
                
            default:
                break;
        }
        CFDictionaryRemoveValue(mActiveConnections, (__bridge const void *)connection);
    }
    if (![self updating]) {
        [mDelegate catalogFinishedUpdating];
    }
}

- (void)connection:(FCConnection *)connection failedWithError:(NSError *)error {
    if (CFDictionaryContainsKey(mActiveConnections, (__bridge const void *)connection))
        CFDictionaryRemoveValue(mActiveConnections, (__bridge const void *)connection);
    if (![self updating]) {
        [mDelegate catalogFinishedUpdating];
    }
}

@end