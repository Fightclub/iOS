//
//  FCGiftListViewController.h
//  Givair
//
//  Created by Peter Tsoi on 12/4/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FCCatalog.h"
#import "FCGraph.h"

@interface FCGiftListViewController : UITableViewController <FCCatalogDelegate, FCGraphDelegate> {
    FCCatalog * mCatalog;
    FCGraph * mGraph;
    UIRefreshControl * mRefreshControl;
}

@end
