//
//  AppDelegate.m
//  3DTouchSample
//
//  Created by RichardLeung on 15/10/31.
//  Copyright © 2015年 RL. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@property(nonatomic,strong)ViewController *viewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor =[UIColor whiteColor];
    _viewController =[[ViewController alloc]init];
    UINavigationController *navigationController =[[UINavigationController alloc]initWithRootViewController:_viewController];
    self.window.rootViewController =navigationController;
    [self.window makeKeyAndVisible];
    
    //动态加载自定义的ShortcutItem
    if (application.shortcutItems.count == 0) {
        UIMutableApplicationShortcutItem *itemThor =[[UIMutableApplicationShortcutItem alloc]initWithType:[NSString stringWithFormat:@"%@.second",[[NSBundle mainBundle] bundleIdentifier]] localizedTitle:@"雷神" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLocation] userInfo:nil];
        UIMutableApplicationShortcutItem *itemBlack =[[UIMutableApplicationShortcutItem alloc]initWithType:[NSString stringWithFormat:@"%@.third",[[NSBundle mainBundle] bundleIdentifier]] localizedTitle:@"黑寡妇" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLocation] userInfo:nil];
        UIMutableApplicationShortcutItem *itemCaptain =[[UIMutableApplicationShortcutItem alloc]initWithType:[NSString stringWithFormat:@"%@.fourth",[[NSBundle mainBundle] bundleIdentifier]] localizedTitle:@"美国队长" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLocation] userInfo:nil];
        application.shortcutItems = @[itemBlack,itemCaptain,itemThor];
    }
    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler{
    [_viewController.navigationController popToRootViewControllerAnimated:NO];
     _viewController.shortcutName =shortcutItem.localizedTitle;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShortCut" object:nil];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //[RLGlobal shareInstance].shortcutStatus =RLShortcutStatusNone;
    _viewController.shortcutName =nil;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
