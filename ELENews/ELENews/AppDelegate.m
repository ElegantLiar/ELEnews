//
//  AppDelegate.m
//  ELENews
//
//  Created by EL on 2017/11/10.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "AppDelegate.h"
#import "ELMainTabBarController.h"
#import "ELNavgationController.h"
#import "YYFPSLabel.h"


@interface AppDelegate ()

@end

@implementation AppDelegate{
    YYFPSLabel              *_fpsLabel;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    kAppStatusBarHeight = IS_iPhoneX ? 44 : 20;
    
    self.window = [[UIWindow alloc] initWithFrame:ELScreenBounds];
    self.window.backgroundColor = ELWhiteColor;
    
    ELMainTabBarController *tabBarVc = [[ELMainTabBarController alloc] init];
    
    ELNavgationController *navgationController = [[ELNavgationController alloc] initWithRootViewController:tabBarVc];

    self.window.rootViewController = navgationController;
    [self.window makeKeyAndVisible];
    
    _fpsLabel = [YYFPSLabel new];
    [_fpsLabel sizeToFit];
    _fpsLabel.centerY = 45;
    _fpsLabel.left = ELScreenW - 90;
    [self.window addSubview:_fpsLabel];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
