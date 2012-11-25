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
        UIScrollView * content = [[UIScrollView alloc] initWithFrame:self.view.frame];
        self.view = content;

        [self.view setBackgroundColor:[UIColor colorWithWhite:0.9216f alpha:1.0f]];
        mCatalog = [[FCCatalog alloc] initWithDelegate:self];
        [mCatalog downloadProductCategoryWithID:1];
        
        mFeaturedCarousel = [[FCCarousel alloc] initWithStyle:FCCarouselStyleBanner];
        [mFeaturedCarousel resize];
        [self.view addSubview:mFeaturedCarousel];

        mCategoryCarousel = [[FCCarousel alloc] initWithStyle:FCCarouselStyleIcons];
        [mCategoryCarousel resize];
        [mCategoryCarousel setFrame:CGRectMake(mFeaturedCarousel.frame.origin.x, mFeaturedCarousel.frame.origin.y + mFeaturedCarousel.frame.size.height,
                                               mCategoryCarousel.frame.size.width, mCategoryCarousel.frame.size.height)];
        [self.view addSubview:mCategoryCarousel];

        mVendorCarousel = [[FCCarousel alloc] initWithStyle:FCCarouselStyleIcons];
        [mVendorCarousel resize];
        [mVendorCarousel setFrame:CGRectMake(mFeaturedCarousel.frame.origin.x, mCategoryCarousel.frame.origin.y + mCategoryCarousel.frame.size.height,
                                             mVendorCarousel.frame.size.width, mVendorCarousel.frame.size.height)];
        [self.view addSubview:mVendorCarousel];

        [content setContentSize:CGSizeMake(self.view.frame.size.width, mVendorCarousel.frame.origin.y + mVendorCarousel.frame.size.height)];
        [content setAlwaysBounceVertical:YES];
    }
    return self;
}

- (void)setupCategoryCarousel {
    NSMutableArray * categories = [NSMutableArray arrayWithArray:[mCatalog getProductCategories]];
    [categories removeObject:[mCatalog getProductCategoryWithID:1]];
    [mCategoryCarousel setTitle:@"Categories"];
    [mCategoryCarousel setObjects:categories];
}

- (void)setupVendorCarousel {
    [mVendorCarousel setTitle:@"Vendors"];
    [mVendorCarousel setObjects:[mCatalog getVendors]];
}

- (void)setupFeaturedCatalog:(FCProductCategory *)category {
    [mFeaturedCarousel setObjects:[category getProducts]];
}

- (void)catalogFinishedUpdating {
    if ([mCategoryCarousel count] != [[mCatalog getProductCategories] count]) {
        [self setupCategoryCarousel];
    }

    if ([mVendorCarousel count] != [[mCatalog getVendors] count]) {
        [self setupVendorCarousel];
    }
    
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
