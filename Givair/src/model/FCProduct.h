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
    int mID;
    float mPrice;
    NSString * mName;
    NSString * mDescription;
    NSString * mSKU;
    FCVendor * mVendor;

    FCImage * mBannerImage;
    FCImage * mIconImage;
}

@property (nonatomic, readonly) int ID;
@property (nonatomic, readonly) float price;
@property (nonatomic, readonly) NSString * name;
@property (nonatomic, readonly) NSString * description;
@property (nonatomic, readonly) NSString * sku;
@property (nonatomic, readonly) FCVendor * vendor;

- (id)initWithID:(int)ID
           price:(float)price name:(NSString*)name
     description:(NSString*)description
             SKU:(NSString*)sku
          vendor:(FCVendor*)vendor
       iconImage:(NSURL *)iconURL
     bannerImage:(NSURL *)bannerURL;
- (void)setBannerImage:(FCImage*)image;
- (void)setIconImage:(FCImage*)image;

@end
