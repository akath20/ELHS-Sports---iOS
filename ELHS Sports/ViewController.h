//
//  ViewController.h
//  ELHS Sports
//
//  Created by Alex Atwater on 2/22/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface ViewController : UIViewController 

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allButtons;
@property (strong, nonatomic) ADBannerView *adBanner;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabels;
@property (strong, nonatomic) IBOutlet UIButton *swimButton;



- (IBAction)iconClicked:(UIButton *)sender;


@end

