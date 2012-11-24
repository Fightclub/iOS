//
//  FCCarouselIconView.h
//  Givair
//
//  Created by Peter Tsoi on 11/24/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FCCarouselObject.h"

#define CAROUSEL_ICON_WIDTH  80.0f
#define CAROUSEL_ICON_HEIGHT 90.0f

@interface FCCarouselIconView : UIView {
    id <FCCarouselObject> mObject;
}

- (id)initWithCarouselObject:(id<FCCarouselObject>)object;

@end