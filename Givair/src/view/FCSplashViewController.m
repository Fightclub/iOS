//
//  FCSplashViewController.m
//  Givair
//
//  Created by Peter Tsoi on 11/27/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "FCSplashViewController.h"

@interface FCSplashViewController ()

@end

@implementation FCSplashViewController

- (id)init {
    self = [super init];
    if (self) {
        CAGradientLayer * gradient = [CAGradientLayer layer];
        gradient.frame = self.view.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0.3686f green:0.6784f blue:0.9098 alpha:1.0f] CGColor], (id)[[UIColor colorWithRed:0.1255f green:0.2941f blue:0.4275 alpha:1.0f] CGColor], nil];
        [self.view.layer insertSublayer:gradient atIndex:0];

        mLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"givairlarge.png"]];
        mLogo.center = CGPointMake(self.view.center.x, self.view.center.y - mLogo.frame.size.height/4);
        [self.view addSubview:mLogo];
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
