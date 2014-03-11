//
//  UINavController.m
//  ELHS Sports
//
//  Created by Alex Atwater on 3/10/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "UINavController.h"
#import "ViewController.h"
#import "WebPageViewController.h"

@interface UINavController ()

@end

@implementation UINavController


- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}



@end
