//
//  FCGiftNavigationController.m
//  Givair
//
//  Created by Peter Tsoi on 11/21/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCGiftNavigationController.h"

#import "FCCatalogViewController.h"
#import "FCGiftListViewController.h"

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
        NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary: [[UINavigationBar appearance] titleTextAttributes]];
        [titleBarAttributes setValue:[UIFont fontWithName:@"MyriadApple-Bold" size:22.0f] forKey:UITextAttributeFont];
        [[UINavigationBar appearance] setTitleTextAttributes:titleBarAttributes];
    }
    return self;
}

- (void)showMyGifts{
    UIViewController * giftsViewController = [[FCGiftListViewController alloc] init];
    // Probably want to use [self presentViewController:<#(UIViewController *)#> animated:<#(BOOL)#> completion:<#^(void)completion#>] instead
    // to get the push up from bottom. Using pushViewController for now since the gift list doesn't have a nav bar.
    [self pushViewController:giftsViewController animated:YES];
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
