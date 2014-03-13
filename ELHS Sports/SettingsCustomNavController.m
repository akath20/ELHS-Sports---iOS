//
//  SettingsCustomNavController.m
//  ELHS Sports
//
//  Created by Alex Atwater on 3/12/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "SettingsCustomNavController.h"

@interface SettingsCustomNavController ()

@end

@implementation SettingsCustomNavController

- (BOOL)shouldAutorotate {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return false;
    } else {
        return true;
    }
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}



@end
