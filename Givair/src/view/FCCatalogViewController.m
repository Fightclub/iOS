//
//  FCCatalogViewController.m
//  Givair
//
//  Created by Peter Tsoi on 11/22/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCCatalogViewController.h"

@interface FCCatalogViewController ()

@end

@implementation FCCatalogViewController

- (id)init {
    self = [super init];
    if (self) {
        self.title = @"Gifts";
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"giftsmall.png"]];
        mCatalog = [[FCCatalog alloc] initWithDelegate:self];
        
        mFeaturedCarousel = [[FCCarousel alloc] initWithStyle:FCCarouselStyleBanner];
        [mFeaturedCarousel resize];
        [self.view addSubview:mFeaturedCarousel];
    }
    return self;
}

- (void)catalogFinishedUpdating {

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
