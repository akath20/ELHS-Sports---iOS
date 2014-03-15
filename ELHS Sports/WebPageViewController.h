//
//  WebPageViewController.h
//  ELHS Sports
//
//  Created by Alex Atwater on 2/22/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface WebPageViewController : UIViewController <UIWebViewDelegate, ADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UINavigationItem *topNavBar;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingAnimation;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *refreshButton;
@property (strong, nonatomic) ADBannerView *adBanner;
@property (strong, nonatomic) UIPopoverController *myPopoverController;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *selectSportButton;

- (IBAction)buttonClicked:(UIButton *)sender;



@end

bool contentIsMoved;





