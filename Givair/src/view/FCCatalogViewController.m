//
//  FCCatalogViewController.m
//  Givair
//
//  Created by Peter Tsoi on 11/22/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCCatalogViewController.h"

#import "FCProduct.h"
#import "FCProductCategory.h"

@interface FCCatalogViewController ()

@end

@implementation FCCatalogViewController

- (id)init {
    self = [super init];
    if (self) {
        self.title = @"Gifts";
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"giftsmall.png"]];
        mCatalog = [[FCCatalog alloc] initWithDelegate:self];
        [mCatalog downloadProductCategoryWithID:1];
        
        mFeaturedCarousel = [[FCCarousel alloc] initWithStyle:FCCarouselStyleBanner];
        [mFeaturedCarousel resize];
        [self.view addSubview:mFeaturedCarousel];
    }
    return self;
}

- (void)setupFeaturedCatalog:(FCProductCategory *)category {
    [mFeaturedCarousel setObjects:[category getProducts]];
}

- (void)catalogFinishedUpdating {
    if ([mFeaturedCarousel count] != [[mCatalog getProductCategoryWithID:1] count]) {
        [self setupFeaturedCatalog:[mCatalog getProductCategoryWithID:1]];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
