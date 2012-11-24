//
//  FCProductCategory.m
//  Givair
//
//  Created by Peter Tsoi on 11/23/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCProductCategory.h"

#import "FCImage.h"
#import "FCProduct.h"

@implementation FCProductCategory

@synthesize ID = mID;
@synthesize name = mName;
@synthesize iconImage = mIconImage;

- (id)initWithID:(int)ID name:(NSString *)name iconImage:(NSURL *)iconURL {
    self = [super init];
    if (self) {
        mID = ID;
        mName = name;
        mIconImage = [[FCImage alloc] initWithURL:iconURL];
        mProducts = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)addProduct:(FCProduct *)product {
    if (![mProducts objectForKey:[NSString stringWithFormat:@"%i", product.ID]]) {
        [mProducts setObject:product forKey:[NSString stringWithFormat:@"%i", product.ID]];
    }
}

@end