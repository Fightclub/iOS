//
//  FCCarouselIconView.h
//  Givair
//
//  Created by Peter Tsoi on 11/24/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FCCarouselObject.h"

#define CAROUSEL_ICON_WIDTH  85.0f
#define CAROUSEL_ICON_HEIGHT 100.0f
#define CAROUSEL_ICON_TITLE_HEIGHT 30.0f

@interface FCCarouselIconView : UIControl {
    id <FCCarouselObject> mObject;
}

- (id)initWithCarouselObject:(id<FCCarouselObject>)object;

@end