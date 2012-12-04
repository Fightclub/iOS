//
//  FCAppDelegate.h
//  Givair
//
//  Created by Peter Tsoi on 11/20/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FCCatalog;
@class FCGraph;
@class FCNetwork;

#define AppDelegate ((FCAppDelegate *)[[UIApplication sharedApplication] delegate])

@interface FCAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate> {
    FCCatalog * mCatalog;
    FCGraph * mGraph;
    FCNetwork * mNetwork;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) FCCatalog * catalog;

@property (strong, nonatomic) FCGraph * graph;

@property (strong, nonatomic) FCNetwork * network;

@end
