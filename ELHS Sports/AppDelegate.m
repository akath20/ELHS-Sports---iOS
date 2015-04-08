//
//  AppDelegate.m
//  ELHS Sports
//
//  Created by Alex Atwater on 2/22/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "AppDelegate.h"
#import "SharedValues.h"
#import <Parse/Parse.h>
#import <sys/utsname.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    self.adBanner = [[ADBannerView alloc] initWithFrame:CGRectZero];
    [self.adBanner setDelegate:self];
    [self.adBanner setAlpha:0.0];
    [[SharedValues allValues] setAdIsLoaded:false];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [[SharedValues allValues] setUrlToLoadAsString:@""];
    }
    
    //create the table view content
    [[SharedValues allValues] createSharedTableContent];
    
    
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"sjsofIbDrcm85z0fS9wCuWu7qlCCP2TNw4gSvX5E"
                  clientKey:@"Ybs4JdJ9FpY2V83R8MX7icob761mOK9QmuWIgkEw"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
   
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:notificationSettings];
        [application registerForRemoteNotifications];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    
    
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:newDeviceToken];
    [currentInstallation setObject:[[UIDevice currentDevice] name] forKey:@"deviceName"];
    [currentInstallation setObject:@"yes" forKey:@"cangetpush"];
    [currentInstallation setObject:[[UIDevice currentDevice] systemVersion] forKey:@"systemVersion"];
    
    
    
    //get the device type
    //*IMPORT* <sys/utsname.h>
    struct utsname systemInfo;
    uname(&systemInfo);
    //NSString *deviceType = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    [currentInstallation setObject:[NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding] forKey:@"hardwareType"];
    
    
    [currentInstallation saveInBackground];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([userDefaults objectForKey:@"push"] != 0) {
        [PFAnalytics trackEventInBackground:@"registeredPush" block:nil];
        [userDefaults setObject:0 forKey:@"push"];
        NSLog(@"Registered for Push. Analytics logged");
    }
    
    
    
    
    
    
    
    
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner{
    
    NSLog(@"\nBanner Loaded");
    [[SharedValues allValues] setAdIsLoaded:true];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"bannerLoaded" object:self];
    
    
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    
    NSLog(@"\nBanner failed to load");
    [[SharedValues allValues] setAdIsLoaded:false];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"bannerError" object:self];
    
    
}

@end
