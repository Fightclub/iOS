//
//  FCVendor.h
//  Givair
//
//  Created by Peter Tsoi on 11/23/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FCImage;

@interface FCVendor : NSObject {
    NSString * mName;
    FCImage * mBannerImage;
    FCImage * mIconImage;
}

- (id)initWithName:(NSString*)name;

- (void)setIconImage:(UIImage*)image;

@end
