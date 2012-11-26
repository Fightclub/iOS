//
//  FCProductCategoryViewController.m
//  Givair
//
//  Created by Peter Tsoi on 11/25/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCProductCategoryViewController.h"

#import "FCIconCell.h"
#import "FCProduct.h"
#import "FCProductViewController.h"
#import "FCProductCategory.h"
#import "FCVendor.h"

@interface FCProductCategoryViewController ()

@end

@implementation FCProductCategoryViewController

- (id)initWithCategory:(FCProductCategory*)category {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        mCategory = category;
        self.title = mCategory.name;
        [self.view setBackgroundColor:[UIColor colorWithWhite:0.9216f alpha:1.0f]];
        [self.tableView setRowHeight:86.0f];
    }
    return self;
}

- (void)setCatalog:(FCCatalog *)catalog {
    mCatalog = catalog;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [mCatalog registerForDelegateCallback:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [mCatalog unregisterForDelegateCallback:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mCategory count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FCIconCell";
    FCIconCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }

    FCProduct * product = [mCategory getProducts][indexPath.row];
    [cell setTitle:product.name];
    [cell setSubtitle:product.vendor.name];
    [cell setIconImage:[product getIcon]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FCProduct * product = [mCategory getProducts][indexPath.row];
    FCProductViewController * newView = [[FCProductViewController alloc] initWithProduct:product];
    [self.navigationController pushViewController:newView animated:YES];
}

#pragma mark - FCCatalogDelegate

- (void)catalogFinishedUpdating {
    [self.tableView reloadData];
}

@end
