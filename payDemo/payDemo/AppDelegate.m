//
//  AppDelegate.m
//  payDemo
//
//  Created by Ampaw on 2016/11/25.
//  Copyright © 2016年 Ampaw. All rights reserved.
//

#import "AppDelegate.h"
#import "WXPayApiManager.h"
#import "UPPayApiManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[WXPayApiManager sharedManager] registerWXPay:@"wxb4ba3c02aa476ea1"];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    [[WXPayApiManager sharedManager] handleOpenURL:url];
    [[UPPayApiManager sharedManager] handleOpenURL:url];
    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    [[WXPayApiManager sharedManager] handleOpenURL:url];
    [[UPPayApiManager sharedManager] handleOpenURL:url];
    return YES;
}

@end
