//
//  FCGiftNavigationController.m
//  Givair
//
//  Created by Peter Tsoi on 11/21/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCGiftNavigationController.h"

#import "FCCatalogViewController.h"

@interface FCGiftNavigationController ()

@end

@implementation FCGiftNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Gifts";
        self.tabBarItem.image = [UIImage imageNamed:@"tabBarGift.png"];
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"blanknavbarbg"] forBarMetrics: UIBarMetricsDefault];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIViewController * catalogViewController = [[FCCatalogViewController alloc] init];
    [self pushViewController:catalogViewController animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
