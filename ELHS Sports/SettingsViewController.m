//
//  SettingsViewController.m
//  ELHS Sports
//
//  Created by Alex Atwater on 2/27/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "SettingsViewController.h"
#import "SharedValues.h"
#import "AppDelegate.h"
#import "Reachability.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
 
    
    //version number
    self.versionLabel.text = [NSString stringWithFormat:@"Version: %@", [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"]];
    
    //set the frame if i move it
    [self.contentView setFrame:CGRectMake(0, 0, 320, self.contentView.frame.size.height)];
    
    //set the content size
    [self.scrollView setContentSize:self.contentView.frame.size];
    
    
    
    //the ad
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadBanner) name:@"bannerLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bannerError) name:@"bannerError" object:nil];
    self.adBanner = SharedAdBannerView;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        //iPhone
        
        [self.adBanner setFrame:CGRectMake(0, 64, 320, 50)];
        
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        //iPhone
        
        [self.adBanner setFrame:CGRectMake(0, 64, 320, 50)];
        
        if (!((int)[[UIScreen mainScreen] bounds].size.height == 568)) {
            
        } else {
            //iPad
            
        }
        
        //add the ad to the view
        [self.view addSubview:self.adBanner];
        if (SharedAdBannerView.isBannerLoaded) {
            [self loadBanner];
        } else {
            [self bannerError];
        }
        
        
    }
    
    
    
}

- (void)viewDidLayoutSubviews {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        //iPhone
        if ((int)[[UIScreen mainScreen] bounds].size.height == 568) {
            //4 inch
            
        }
    }
    
}

- (IBAction)launchWebsite:(id)sender {
    
    //load the string
    [[SharedValues allValues] setUrlToLoadAsString:@"http://webpages.charter.net/akath20/"];
    
    //switch the view
    //check for internet connection
    if (![Reachability checkForInternetWithString:Nil]) {
        //show alert from the class
        [[Reachability showAlertNoInternet] show];
    } else {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            //iPhone
            //swith view
            [self performSegueWithIdentifier:@"showMyWebsite" sender:Nil];
            
        } else {
            //iPad
            //reload webpage and dismiss popover
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadWebPage" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissPopover" object:nil];
            
        }
        
    }

}

- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"bannerLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"bannerError" object:nil];
}

- (void)loadBanner {
    if (self.adBanner.alpha < 1) {
        [UIView animateWithDuration:.5 animations:^{
            [self.adBanner setAlpha:1];
        }];
        
    }
    
}

- (void)bannerError {
    if (self.adBanner.alpha > 0) {
        [self.adBanner setAlpha:0];
    }
    
}

@end
