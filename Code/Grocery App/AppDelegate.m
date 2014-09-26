//
//  AppDelegate.m
//  Grocery App
//
//  Created by Rishabh Tayal on 9/24/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import "AppDelegate.h"
#import <Crashlytics/Crashlytics.h>
#import <PayPal-iOS-SDK/PayPalMobile.h>
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Crashlytics startWithAPIKey:@"02d3f7db22ac1a3e538528547a694d5230eb8278"];

    [MagicalRecord setupCoreDataStack];
    
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction: @"AXN8ThDXFkgG2A7V6YuTTShIRz_KTNxdWwG3xj32C1BatV6_x1jUwk8PxSK_", PayPalEnvironmentSandbox:@"ARbi8xAoZXv_X4OvTfovyvHvbO-frUBlowY_D5GU0VsmrV8NhDNYPBC30Zoa"}];
    
    [Parse setApplicationId:@"sTY3mDitYI1kOD7JGC3cix44zTq2SeNHyVkukYtD" clientKey:@"rNaV7UkDdCzu4MvGczNIYVMwemuhuNBjr9uCVAry"];
    
    return YES;
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [PFPush handlePush:userInfo];
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    PFInstallation* currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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
