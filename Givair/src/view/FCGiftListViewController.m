//
//  FCGiftListViewController.m
//  Givair
//
//  Created by Peter Tsoi on 12/4/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCGiftListViewController.h"

#import "FCRedemptionViewController.h"

#import "FCAppDelegate.h"
#import "FCGift.h"
#import "FCIconCell.h"
#import "FCProduct.h"
#import "FCUser.h"
#import "FCVendor.h"

@interface FCGiftListViewController ()

@end

@implementation FCGiftListViewController

- (id)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        [self.view setBackgroundColor:[UIColor colorWithWhite:0.9216f alpha:1.0f]];
        [self.tableView setRowHeight:86.0f];
        mCatalog = AppDelegate.catalog;
        mGraph = AppDelegate.graph;
        [mGraph registerForDelegateCallback:self];
        [mGraph downloadGiftsForUserWithKey:[[NSUserDefaults standardUserDefaults] objectForKey:@"apikey"]];
    }
    return self;
}

- (void)viewDidLoad {
    mRefreshControl = [[UIRefreshControl alloc] init];
    [mRefreshControl addTarget:self action:@selector(refreshGifts) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:mRefreshControl];

}

- (void)refreshGifts {
    [mGraph downloadGiftsForUserWithKey:[[NSUserDefaults standardUserDefaults] objectForKey:@"apikey"]];
}

- (void)setCatalog:(FCCatalog *)catalog {
    mCatalog = catalog;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [mCatalog registerForDelegateCallback:self];
    [mGraph registerForDelegateCallback:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [mCatalog unregisterForDelegateCallback:self];
    [mGraph unregisterForDelegateCallback:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FCUser * thisUser = [mGraph getUserWithID:[[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] intValue]];
    return [[thisUser getReceivedGifts] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FCIconCell";
    FCIconCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }

    FCUser * user = [mGraph getUserWithID:[[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] intValue]];
    FCGift * gift = [[user getReceivedGifts] objectAtIndex:indexPath.row];

    [cell setTitle:gift.product.name];
    [cell setSubtitle:[NSString stringWithFormat:@"from %@ %@", gift.sender.first, gift.sender.last]];
    [cell setIconImage:[gift.product getIcon]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FCUser * user = [mGraph getUserWithID:[[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] intValue]];
    FCGift * gift = [[user getReceivedGifts] objectAtIndex:indexPath.row];
    FCRedemptionViewController * newView = [[FCRedemptionViewController alloc] initWithGift:gift];
    [self.navigationController presentViewController:newView animated:YES completion:nil];
}

#pragma mark - FCCatalogDelegate

- (void)catalogFinishedUpdating {

    [self.tableView reloadData];
}

#pragma mark - FCGraphDelegate

- (void)graphFinishedUpdating {
    if (mRefreshControl) {
        [mRefreshControl endRefreshing];
    }
    [self.tableView reloadData];
}

@end
