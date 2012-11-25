//
//  FCCarouselObject.h
//  Givair
//
//  Created by Peter Tsoi on 11/24/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FCImage;

@protocol FCCarouselObject

- (NSString*)getName;
- (FCImage*)getIcon;
- (FCImage*)getBanner;

@optional
- (NSString*)getDescription;

@end