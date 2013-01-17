//
//  FCVendor.m
//  Givair
//
//  Created by Peter Tsoi on 11/23/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCVendor.h"

#import "FCImage.h"
#import "FCProduct.h"

@implementation FCVendor

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

- (NSString*)getDescription {
    return @"Description";
}

- (void)addProduct:(FCProduct *)product {
    if (![mProducts objectForKey:[NSString stringWithFormat:@"%i", product.ID]]) {
        [mProducts setObject:product forKey:[NSString stringWithFormat:@"%i", product.ID]];
    }
}

- (int)count {
    return [mProducts count];
}

- (NSString *)getName {
    return mName;
}

- (FCImage *)getIcon {
    return mIconImage;
}

- (NSArray *)getProducts {
    return [mProducts allValues];
}

@end
