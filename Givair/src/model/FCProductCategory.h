//
//  FCProductCategory.h
//  Givair
//
//  Created by Peter Tsoi on 11/23/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FCImage;
@class FCProduct;

@interface FCProductCategory : NSObject {
    int mID;
    NSString * mName;
    FCImage * mIconImage;

    NSMutableDictionary * mProducts;
}

@property (nonatomic, readonly) int ID;
@property (nonatomic, readonly) NSString * name;
@property (nonatomic) FCImage * iconImage;

- (id)initWithID:(int)ID name:(NSString *)name iconImage:(NSURL *)iconURL;
- (void)addProduct:(FCProduct *)product;

@end
