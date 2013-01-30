//
//  FCPeopleNavigationController.m
//  Givair
//
//  Created by Peter Tsoi on 11/21/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import "FCPeopleNavigationController.h"

@interface FCPeopleNavigationController ()

@end

@implementation FCPeopleNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"People";
        self.tabBarItem.image = [UIImage imageNamed:@"tabBarPeople.png"];
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"blanknavbarbg"] forBarMetrics: UIBarMetricsDefault];
    }
    return self;
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
