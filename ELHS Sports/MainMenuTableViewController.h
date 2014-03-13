//
//  MainMenuTableViewController.h
//  ELHS Sports
//
//  Created by Alex Atwater on 3/12/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface MainMenuTableViewController : UITableViewController

@property (strong, nonatomic) ADBannerView *adBanner;
@property (strong, nonatomic) NSArray *tableContent;

@end
