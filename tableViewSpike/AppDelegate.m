//
//  AppDelegate.m
//  tableViewSpike
//
//  Created by u16suzu on 2013/09/15.
//  Copyright (c) 2013年 u16suzu. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *vc = [[ViewController alloc]init];
    self.navigationController =
      [[UINavigationController alloc]initWithRootViewController: vc];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
