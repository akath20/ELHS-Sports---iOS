//
//  AppDelegate.m
//  ELHS Sports
//
//  Created by Alex Atwater on 2/22/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    self.adBanner = [[ADBannerView alloc] initWithFrame:CGRectZero];
    [self.adBanner setDelegate:self];
    [self.adBanner setAlpha:0.0];
    return YES;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner{
    
    NSLog(@"BannerLoaded");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"bannerLoaded" object:self];
    
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    
    if (self.adBanner.bannerLoaded == true) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"bannerError" object:self];
    }
}

@end
