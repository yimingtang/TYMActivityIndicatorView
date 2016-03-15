//
//  TYMAppDelegate.m
//  TYMActivityIndicatorView
//
//  Created by Yiming Tang on 2/9/14.
//  Copyright (c) 2014 - 2016 Yiming Tang. All rights reserved.
//

#import "TYMAppDelegate.h"
#import "TYMDemoViewController.h"

@implementation TYMAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[TYMDemoViewController alloc] init];;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
