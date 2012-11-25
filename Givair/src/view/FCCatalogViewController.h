//
//  FCCatalogViewController.h
//  Givair
//
//  Created by Peter Tsoi on 11/22/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FCCatalog.h"
#import "FCCarousel.h"

@interface FCCatalogViewController : UIViewController <FCCatalogDelegate, FCCarouselDelegate> {
    FCCatalog * mCatalog;
    FCCarousel * mFeaturedCarousel;
}

@end
