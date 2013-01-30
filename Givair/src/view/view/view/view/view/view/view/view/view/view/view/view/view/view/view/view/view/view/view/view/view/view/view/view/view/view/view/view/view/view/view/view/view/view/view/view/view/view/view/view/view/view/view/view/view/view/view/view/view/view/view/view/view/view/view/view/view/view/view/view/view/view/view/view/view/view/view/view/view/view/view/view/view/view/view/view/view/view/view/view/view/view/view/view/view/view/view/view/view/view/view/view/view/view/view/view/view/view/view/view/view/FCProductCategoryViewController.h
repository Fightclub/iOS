//
//  FCProductCategoryViewController.h
//  Givair
//
//  Created by Peter Tsoi on 11/25/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FCCatalog.h"

@class FCProductCategory;

@interface FCProductCategoryViewController : UITableViewController <FCCatalogDelegate> {
    FCProductCategory * mCategory;
    FCCatalog * mCatalog;
}

- (id)initWithCategory:(FCProductCategory*)category;
- (void)setCatalog:(FCCatalog *)catalog;

@end
