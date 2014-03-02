//
//  SettingsViewController.h
//  ELHS Sports
//
//  Created by Alex Atwater on 2/27/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface SettingsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *versionLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) ADBannerView *adBanner;

- (IBAction)launchWebsite:(id)sender;



@end
