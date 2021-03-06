//
//  AppDelegate.h
//  ELHS Sports
//
//  Created by Alex Atwater on 2/22/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#define SharedAdBannerView ((AppDelegate *)[[UIApplication sharedApplication] delegate]).adBanner
#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface AppDelegate : UIResponder <UIApplicationDelegate, ADBannerViewDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ADBannerView *adBanner;

@end
