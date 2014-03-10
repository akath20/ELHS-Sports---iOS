//
//  WebPageViewController.m
//  ELHS Sports
//
//  Created by Alex Atwater on 2/22/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "WebPageViewController.h"
#import "SharedValues.h"
#import "AppDelegate.h"
#import "Reachability.h"

@interface WebPageViewController ()

@end

@implementation WebPageViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadBanner) name:@"bannerLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bannerError) name:@"bannerError" object:nil];
    
    
    self.adBanner = SharedAdBannerView;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        //iPhone
        //set the screen accordingly with the phone model
        if ((int)[[UIScreen mainScreen] bounds].size.height == 568) {
            // This is iPhone 5 screen
            [self.backButton setFrame:CGRectMake(10, 527, 32, 29)];
            [self.refreshButton setFrame:CGRectMake(281, 527, 32, 29)];
            [self.webView setFrame:CGRectMake(0, 64, 320, 504)];
            [self.loadingAnimation setFrame:CGRectMake(142, 298, self.loadingAnimation.frame.size.width, self.loadingAnimation.frame.size.height)];
            [self.adBanner setFrame:CGRectMake(0, 518, 320, 50)];
        } else {
            //this is the 4/4s screen
            [self.backButton setFrame:CGRectMake(10, 444, 32, 29)];
            [self.refreshButton setFrame:CGRectMake(281, 444, 32, 29)];
            [self.webView setFrame:CGRectMake(0, 64, 320, 416)];
            [self.loadingAnimation setFrame:CGRectMake(142, 243, self.loadingAnimation.frame.size.width, self.loadingAnimation.frame.size.height)];
            [self.adBanner setFrame:CGRectMake(0, 430, 320, 50)];
            
        }
        
    } else {
        //iPad
        [self iPadOrientationSetUp];
    }
  
    

    
    [self setAutomaticallyAdjustsScrollViewInsets:false];
    
    //Setup The Web View
    [self setupTheWebView];
    
    //set the title of the nav bar
    if ([[[SharedValues allValues] urlToLoadAsString] isEqualToString:@""]) {
        self.topNavBar.title = @"Home";
    } else {
        self.topNavBar.title = [[SharedValues allValues] urlToLoadAsString];
    }
    
    //configure the buttons at the bottem
    if (self.webView.canGoBack) {
        [self.backButton setHidden:false];
    } else {
        [self.backButton setHidden:true];
    }
    
    
    if ([[SharedValues allValues] adDidLoadOnce]) {
        [self.backButton setFrame:CGRectMake(self.backButton.frame.origin.x, self.backButton.frame.origin.y - 50, self.backButton.frame.size.width, self.backButton.frame.size.height)];
        [self.refreshButton setFrame:CGRectMake(self.refreshButton.frame.origin.x, self.refreshButton.frame.origin.y - 50, self.refreshButton.frame.size.width, self.refreshButton.frame.size.height)];
        [self.webView setFrame:CGRectMake(self.webView.frame.origin.x, self.webView.frame.origin.y, self.webView.frame.size.width, self.webView.frame.size.height - 50)];
        
    }
    
    if (SharedAdBannerView.isBannerLoaded) {
        [self loadBanner];
    } else {
        [self bannerError];
    }
    
    //add the ad
    [self.view addSubview:self.adBanner];
    
    
}




- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"bannerLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"bannerError" object:nil];
    self.webView = nil;
}

- (void)setupTheWebView {
    
    //get the webpage to load
    NSString *urlToLoadAsString = [[SharedValues allValues] urlToLoadAsString];
    
    if (![urlToLoadAsString isEqualToString:@"http://webpages.charter.net/akath20/"]) {
        //if not coming from my website but from homescreen
        
        //convert to URL
        NSURL *urlToLoadAsURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://www.eastlongmeadowsports.com/%@", urlToLoadAsString]];
        
        //make a load request
        NSURLRequest *urlToLoadRequest = [[NSURLRequest alloc] initWithURL:urlToLoadAsURL];
        
        //load the webpage
        [self.webView loadRequest:urlToLoadRequest];
        
    } else {
        //if coming from the settings and showing my website
        
        //convert to URL
        NSURL *urlToLoadAsURL = [[NSURL alloc] initWithString:urlToLoadAsString];
        
        //make a load request
        NSURLRequest *urlToLoadRequest = [[NSURLRequest alloc] initWithURL:urlToLoadAsURL];
        
        //load the webpage
        [self.webView loadRequest:urlToLoadRequest];
        
        
    }
    
    
}

- (IBAction)buttonClicked:(UIButton *)sender {
    
    if (sender.tag == 0) {
        //if the back button
        [self.webView goBack];
        
    } else {
        
        //if the refresh button
        [self.webView reload];
        
    }
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.loadingAnimation setHidden:false];
    [self.refreshButton setHidden:TRUE];
    [self.loadingAnimation startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.loadingAnimation setHidden:TRUE];
    [self.loadingAnimation stopAnimating];
    [self.refreshButton setHidden:false];
    
    //see if the back button should be shown
    if ([self.webView canGoBack]) {
        [self.backButton setHidden:false];
    } else {
        [self.backButton setHidden:TRUE];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    //check the internet connection
    if (![Reachability checkForInternetWithString:nil]) {
        //no internet
        [[Reachability showAlertNoInternet] show];
    } else {
        //other error
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"An Error Occured" message:[NSString stringWithFormat:@"An Error Occured. Please try again, if problem continues, please contact support. \n%@", error] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [errorAlert show];
    }
    
    
    [self.navigationController popToRootViewControllerAnimated:TRUE];
    
}

- (void)viewDidLayoutSubviews {
    if (!(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)) {
        //if iPad (should only be iPad that rotates)
        [self iPadOrientationSetUp];
    }
}

- (void)iPadOrientationSetUp {
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) {
        //if portrait
        [self.webView setFrame:CGRectMake(0, 64, 768, 960)];
        [self.adBanner setFrame:CGRectMake(0, 958, 768, 66)];
        [self.refreshButton setFrame:CGRectMake(709, 965, self.refreshButton.frame.size.width, self.refreshButton.frame.size.height)];
        [self.backButton setFrame:CGRectMake(20, 965, self.backButton.frame.size.width, self.backButton.frame.size.height)];
        [self.loadingAnimation setFrame:CGRectMake(366, 525, self.loadingAnimation.frame.size.width, self.loadingAnimation.frame.size.height)];
        
    } else {
        //if landscape
        [self.backButton setFrame:CGRectMake(20, 709, self.backButton.frame.size.width, self.backButton.frame.size.height)];
        [self.refreshButton setFrame:CGRectMake(965, 709, self.refreshButton.frame.size.width, self.refreshButton.frame.size.height)];
        [self.webView setFrame:CGRectMake(0, 64, 1024, 704)];
        [self.loadingAnimation setFrame:CGRectMake(494, 397, self.loadingAnimation.frame.size.width, self.loadingAnimation.frame.size.height)];
        [self.adBanner setFrame:CGRectMake(0, 702, 1024, 66)];
        
    }
    
    //the iAd
    if ([[SharedValues allValues] adDidLoadOnce]) {
        [self.backButton setFrame:CGRectMake(self.backButton.frame.origin.x, self.backButton.frame.origin.y - 60, self.backButton.frame.size.width, self.backButton.frame.size.height)];
        [self.refreshButton setFrame:CGRectMake(self.refreshButton.frame.origin.x, self.refreshButton.frame.origin.y - 60, self.refreshButton.frame.size.width, self.refreshButton.frame.size.height)];
        [self.webView setFrame:CGRectMake(self.webView.frame.origin.x, self.webView.frame.origin.y, self.webView.frame.size.width, self.webView.frame.size.height - 66)];
        
    }

    
    
}

- (void)loadBanner {
    [self.adBanner setAlpha:1];
    if (![[SharedValues allValues] adDidLoadOnce]) {
        //move everything up
        [self.backButton setFrame:CGRectMake(self.backButton.frame.origin.x, self.backButton.frame.origin.y - 50, self.backButton.frame.size.width, self.backButton.frame.size.height)];
        [self.refreshButton setFrame:CGRectMake(self.refreshButton.frame.origin.x, self.refreshButton.frame.origin.y - 50, self.refreshButton.frame.size.width, self.refreshButton.frame.size.height)];
        
        [self.webView setFrame:CGRectMake(self.webView.frame.origin.x, self.webView.frame.origin.y, self.webView.frame.size.width, self.webView.frame.size.height - 50)];
        [[SharedValues allValues] setAdDidLoadOnce:TRUE];
    }
    
}

- (void)bannerError {
    if ([[SharedValues allValues] adDidLoadOnce]) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            //iPhone
            //set the screen accordingly with the phone model
            if ((int)[[UIScreen mainScreen] bounds].size.height  == 568) {
                // This is iPhone 5 screen
                [self.backButton setFrame:CGRectMake(10, 527, 32, 29)];
                [self.refreshButton setFrame:CGRectMake(281, 527, 32, 29)];
                [self.webView setFrame:CGRectMake(0, 64, 320, 504)];
                [self.loadingAnimation setFrame:CGRectMake(142, 298, self.loadingAnimation.frame.size.width, self.loadingAnimation.frame.size.height)];
                [self.adBanner setFrame:CGRectMake(0, 518, 320, 50)];
            } else {
                //this is the 4/4s screen
                [self.backButton setFrame:CGRectMake(10, 444, 32, 29)];
                [self.refreshButton setFrame:CGRectMake(281, 444, 32, 29)];
                [self.webView setFrame:CGRectMake(0, 64, 320, 416)];
                [self.loadingAnimation setFrame:CGRectMake(142, 243, self.loadingAnimation.frame.size.width, self.loadingAnimation.frame.size.height)];
                [self.adBanner setFrame:CGRectMake(0, 430, 320, 50)];
                
            }
            
        } else {
            //iPad
        }
    }
    [self.adBanner setAlpha:0.0];
}






@end
