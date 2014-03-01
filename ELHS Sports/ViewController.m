//
//  ViewController.m
//  ELHS Sports
//
//  Created by Alex Atwater on 2/22/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "ViewController.h"
#import "SharedValues.h"
#import "AppDelegate.h"

@interface ViewController () 

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadBanner) name:@"bannerLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bannerError) name:@"bannerError" object:nil];
    
    
    self.adBanner = SharedAdBannerView;
    
    

    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        //iPhone
        
        [self.adBanner setFrame:CGRectMake(0, 64, 320, 50)];
    } else {
        //iPad
        
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


- (IBAction)iconClicked:(UIButton *)sender {
    
    //get title of the selected image
    NSString *selectedSport = [[NSString alloc] initWithString:sender.titleLabel.text];
    
    //decide what to set the value as
    if ([selectedSport isEqualToString:@"Basketball"]) {
        [[SharedValues allValues] setUrlToLoadAsString:@"Basketball"];
    } else if ([selectedSport isEqualToString:@"Hockey"]) {
        [[SharedValues allValues] setUrlToLoadAsString:@"Hockey"];
    } else if ([selectedSport isEqualToString:@"Wrestling"]) {
        [[SharedValues allValues] setUrlToLoadAsString:@"Wrestling"];
    } else if ([selectedSport isEqualToString:@"Soccer"]) {
        [[SharedValues allValues] setUrlToLoadAsString:@"Soccer"];
    } else if ([selectedSport isEqualToString:@"Swimming"]) {
        [[SharedValues allValues] setUrlToLoadAsString:@"Swimming"];
    } else if ([selectedSport isEqualToString:@"Skiing"]) {
        [[SharedValues allValues] setUrlToLoadAsString:@"Skiing"];
    } else if ([selectedSport isEqualToString:@"Track"]) {
        [[SharedValues allValues] setUrlToLoadAsString:@"Track"];
    } else if ([selectedSport isEqualToString:@"Home"]) {
        [[SharedValues allValues] setUrlToLoadAsString:@""];
    } else {
        NSLog(@"\nError; Bad title for button.");
    }
    
    //switch the view
    [self performSegueWithIdentifier:@"showWebPage" sender:Nil];
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
