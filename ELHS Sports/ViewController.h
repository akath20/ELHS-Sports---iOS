//
//  ViewController.h
//  ELHS Sports
//
//  Created by Alex Atwater on 2/22/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface ViewController : UIViewController <ADBannerViewDelegate>

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allButtons;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabels;

@property (strong, nonatomic) IBOutlet ADBannerView *adBanner;

- (IBAction)iconClicked:(UIButton *)sender;


@end

