//
//  EBAppDelegate.m
//  Cumber-Test
//
//  Created by Chip Snyder on 1/5/14.
//  Copyright (c) 2014 Education. All rights reserved.
//

#import "EBAppDelegate.h"
#import "EBUIAElementViewController.h"

@implementation EBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    EBUIAElementViewController *elementVC = [[EBUIAElementViewController alloc] init];
    
    UINavigationController *masterNavigation = [[UINavigationController alloc] initWithRootViewController:elementVC];
    
    [[self window] setRootViewController:masterNavigation];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
