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
        mFeaturedCarousel.delegate = self;
        [mFeaturedCarousel resize];
        [self.view addSubview:mFeaturedCarousel];

        mCategoryCarousel = [[FCCarousel alloc] initWithStyle:FCCarouselStyleIcons];
        mCategoryCarousel.delegate = self;
        [mCategoryCarousel resize];
        [mCategoryCarousel setFrame:CGRectMake(mFeaturedCarousel.frame.origin.x, mFeaturedCarousel.frame.origin.y + mFeaturedCarousel.frame.size.height,
                                               mCategoryCarousel.frame.size.width, mCategoryCarousel.frame.size.height)];
        [self.view addSubview:mCategoryCarousel];

        mVendorCarousel = [[FCCarousel alloc] initWithStyle:FCCarouselStyleIcons];
        mVendorCarousel.delegate = self;
        [mVendorCarousel resize];
        [mVendorCarousel setFrame:CGRectMake(mFeaturedCarousel.frame.origin.x, mCategoryCarousel.frame.origin.y + mCategoryCarousel.frame.size.height,
                                             mVendorCarousel.frame.size.width, mVendorCarousel.frame.size.height)];
        [self.view addSubview:mVendorCarousel];

        [content setContentSize:CGSizeMake(self.view.frame.size.width, mVendorCarousel.frame.origin.y + mVendorCarousel.frame.size.height)];
        [content setAlwaysBounceVertical:YES];

        mSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        mSpinner.center = mCategoryCarousel.center;
        [self.view addSubview:mSpinner];

        mStatusLabel = [[UILabel alloc] init];
        [mStatusLabel setFont:[UIFont fontWithName:@"MyriadApple-Bold" size:18.0f]];
        [mStatusLabel setShadowColor:[UIColor whiteColor]];
        [mStatusLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
        [mStatusLabel setTextColor:[UIColor colorWithWhite:0.37f alpha:1.0f]];
        [mStatusLabel setTextAlignment:NSTextAlignmentCenter];
        [mStatusLabel setBackgroundColor:[UIColor clearColor]];
        [mStatusLabel setFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width*0.5, 25.0f)];
        [mStatusLabel setCenter:CGPointMake(mSpinner.center.x, mSpinner.center.y+25.0f)];

        [mStatusLabel setText:@"Loading"];
        [self.view addSubview:mStatusLabel];
        [mSpinner startAnimating];
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

    if ([mSpinner isAnimating] && [[mCatalog getVendors] count] == 0 && [[mCatalog getProductCategories] count] == 0) {
        [mSpinner stopAnimating];
        [mSpinner removeFromSuperview];
        mStatusLabel.text = @"Connection Failed.";
    } else if ([mSpinner isAnimating]) {
        [mSpinner stopAnimating];
        [mSpinner removeFromSuperview];
        [mStatusLabel removeFromSuperview];
    }
}

- (void)didSelectCarouselObject:(id<FCCarouselObject>)object {

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
