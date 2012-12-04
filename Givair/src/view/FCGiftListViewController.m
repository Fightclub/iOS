//
//  FCGiftListViewController.m
//  Givair
//
//  Created by Peter Tsoi on 12/4/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCGiftListViewController.h"

#import "FCAppDelegate.h"
#import "FCIconCell.h"

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
    }
    return self;
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
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FCIconCell";
    FCIconCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }

    return cell;
}

#pragma mark - FCCatalogDelegate

- (void)catalogFinishedUpdating {
    [self.tableView reloadData];
}

#pragma mark - FCGraphDelegate

- (void)graphFinishedUpdating {
    [self.tableView reloadData];
}

@end
