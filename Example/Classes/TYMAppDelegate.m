//
//  TYMAppDelegate.m
//  Example
//
//  Created by Yiming Tang on 14-2-9.
//  Copyright (c) 2014 Yiming Tang. All rights reserved.
//

#import "TYMAppDelegate.h"
#import "TYMDemoViewController.h"

@implementation TYMAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    TYMDemoViewController *demoViewController = [[TYMDemoViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:demoViewController];
    self.window.rootViewController = navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
