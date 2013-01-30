//
//  FCFriendSelectViewController.h
//  Givair
//
//  Created by Peter Tsoi on 1/29/13.
//  Copyright (c) 2013 Fightclub. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FCProduct;

@interface FCFriendSelectViewController : UITableViewController {
    FCProduct * mGift;
}

- (id)initWithGift:(FCProduct*)gift;

@end
