//
//  AppDelegate.m
//  Xib使用
//
//  Created by 微光星芒 on 2017/7/27.
//  Copyright © 2017年 微光星芒. All rights reserved.
//

#import "AppDelegate.h"
#import "RootController.h"
#import "FirstController.h"
#import "ThirdController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    RootController *controller = [[RootController alloc]initWithNibName:@"RootController" bundle:nil];
    
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:controller];
    //隐式加载

//    FirstController *controller = [[FirstController alloc]init];
    
//    ThirdController *controller = [[ThirdController alloc]init];
    self.window.rootViewController = navController;
    
    switch (isStore) {
        case 1:{
            NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
//            NSLog(@"****************%@",bundleId);

        }
            break;
        case 2:{
            NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
//            NSLog(@"****************%@",bundleId);
        }
            break;
    }
    
    
    [self.window makeKeyAndVisible];
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
