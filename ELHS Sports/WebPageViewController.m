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
#import <Social/Social.h>


@interface WebPageViewController ()

@end

@implementation WebPageViewController

- (void)viewWillAppear:(BOOL)animated {
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadBanner) name:@"bannerLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bannerError) name:@"bannerError" object:nil];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //if iPad
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupTheWebView) name:@"reloadWebPage" object:nil];
        
        
        //set the top bar with custom buttons
        UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareButtonClicked:)];
        NSArray *myButtonArray = [[NSArray alloc] initWithObjects:self.selectSportButton, shareButton, nil];
        self.topNavBar.rightBarButtonItems = myButtonArray;
    }
    
    
    
    self.adBanner = SharedAdBannerView;
    
    [self setAutomaticallyAdjustsScrollViewInsets:false];
    
    //Setup The Web View
    [self setupTheWebView];
    

    //configure the buttons at the bottem
    if (self.webView.canGoBack) {
        [self.backButton setHidden:false];
    } else {
        [self.backButton setHidden:true];
    }
    
    if ([[SharedValues allValues] adIsLoaded]) {
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
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //if iPad
        //this shouldn't even be called on an iPad
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadWebPage" object:nil];
    }
    
    
    self.webView = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"popOverSegue"] || [segue.identifier isEqualToString:@"showSettings"]) {
        if ([segue isKindOfClass:[UIStoryboardPopoverSegue class]]) {
            UIStoryboardPopoverSegue *popoverSegue = (UIStoryboardPopoverSegue *)segue;
            self.myPopoverController = popoverSegue.popoverController;
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissPopover) name:@"dismissPopover" object:nil];
        }
    }
}

- (void)dismissPopover {
    
    [self.myPopoverController dismissPopoverAnimated:true];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"dismissPopover" object:nil];
    
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
    
    //set the title of the nav bar
    if ([[[SharedValues allValues] urlToLoadAsString] isEqualToString:@""]) {
        self.topNavBar.title = @"Home";
    } else if ([urlToLoadAsString isEqualToString:@"http://webpages.charter.net/akath20/"]) {
        self.topNavBar.title = @"AKA Software Development";
    } else {
        self.topNavBar.title = [[SharedValues allValues] urlToLoadAsString];
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

- (IBAction)shareButtonClicked:(id)sender {
    
    UIActionSheet *twitterOrFacebook = [[UIActionSheet alloc] initWithTitle:@"Share" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Twitter", @"Facebook", @"SMS", @"Email", @"Copy Link", @"Open in Safari", nil];
    [twitterOrFacebook showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //title of the webpage to share
    NSString *pageTitle = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSString *justPageTitle = [NSString stringWithString:pageTitle];
    justPageTitle = [justPageTitle stringByReplacingOccurrencesOfString:@" - East Longmeadow Sports.com" withString:@""];
    pageTitle = [pageTitle stringByReplacingOccurrencesOfString:@"s.com" withString:@"s .com"];
    
    NSURL *currentURL = [NSURL URLWithString:self.webView.request.URL.absoluteString];
    
    if (buttonIndex == 0) {
        
        //Twitter
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet addURL:currentURL];
        [tweetSheet setInitialText:justPageTitle];
        
        [self presentViewController:tweetSheet animated:true completion:nil];
        
    } else if (buttonIndex == 1) {
        
        //Facebook
        SLComposeViewController *facebookSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [facebookSheet setInitialText:pageTitle];
        [facebookSheet addURL:currentURL];
        
        //present
        [self presentViewController:facebookSheet animated:true completion:nil];
        
    } else if (buttonIndex == 2) {
        
        //SMS
        MFMessageComposeViewController *messageSheet = [[MFMessageComposeViewController alloc] init];
        
        messageSheet.messageComposeDelegate = self;
        
        [messageSheet setBody:[NSString stringWithFormat:@"%@\n%@", justPageTitle, currentURL.absoluteString]];
        
        [self presentViewController:messageSheet animated:true completion:nil];
        
        
        
        
    } else if (buttonIndex == 3) {
        
        //Email
        
        MFMailComposeViewController *emailSheet = [[MFMailComposeViewController alloc] init];
        
        emailSheet.mailComposeDelegate = self;
        
        [emailSheet setSubject: justPageTitle];
        
        
        // Fill out the email body text.
    
        NSString *emailBody = [NSString stringWithFormat:@"%@\n%@ \n\r\n\r\n\rSent from the ELHS Sports iPhone App.", justPageTitle, currentURL.absoluteString];
        [emailSheet setMessageBody:emailBody isHTML:NO];
        
        // Present the mail composition interface.
        [self presentViewController:emailSheet animated:true completion:nil];
        
    } else if (buttonIndex == 4) {
        
        //Copy Link
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = [NSString stringWithFormat:@"%@\n%@", justPageTitle, currentURL.absoluteString];
        
    } else if (buttonIndex == 5) {
        
        //Open in Safari
        
        UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle:@"Are You Sure?" message:@"Are you sure you want to leave the app?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [areYouSure show];
        
        
        
    } else if (buttonIndex == -1) {
        
        //cancel button
        
    } else {
        //error OR user clicked off the actionsheet

    }
    
    
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:true completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [controller dismissViewControllerAnimated:true completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView.title isEqualToString:@"Are You Sure?"]) {
        if (buttonIndex == 0) {
            //hit cancel
            return;
        } else if (buttonIndex == 1) {
            NSURL *currentURL = [NSURL URLWithString:self.webView.request.URL.absoluteString];
            [[UIApplication sharedApplication] openURL:currentURL];
        } else {
            NSLog(@"\nAlert buttonIndex Error");
        }
        
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.loadingAnimation setHidden:false];
    [self.loadingAnimation startAnimating];
    //[self.refreshButton setHidden:TRUE];
    //[self.backButton setHidden:true];
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
        
        NSLog(@"\nWebView Error Code #: %li", (long)error.code);
        
        if (error.code == NSURLErrorCancelled) {
            //this is the error when the user tries to load another page before the other is done, just ignore this
            return;
        } else {
            //other error
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"An Error Occured" message:[NSString stringWithFormat:@"An Error Occured. Please try again, if problem continues, please contact support. \n\n%@", error] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [errorAlert show];
        }
    }
    
    
    [self.navigationController popToRootViewControllerAnimated:TRUE];
    
}

- (void)viewDidLayoutSubviews {

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        //iPhone
        if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait) {
            
            //if portrait
            
            if (![[SharedValues allValues] adIsLoaded]) {
                //if no ad present
                
                if ((int)[[UIScreen mainScreen] bounds].size.height == 568) {
                    //4 inch
                    [self.webView setFrame:CGRectMake(0, 64, 320, 504)];
                    [self.backButton setFrame:CGRectMake(10, 527, 32, 29)];
                    [self.adBanner setFrame:CGRectMake(0, 518, 320, 50)];
                    [self.refreshButton setFrame:CGRectMake(281, 527, 32, 29)];
                    
                } else {
                    //3.5 inch
                    [self.backButton setFrame:CGRectMake(10, 444, 32, 29)];
                    [self.refreshButton setFrame:CGRectMake(281, 444, 32, 29)];
                    [self.webView setFrame:CGRectMake(0, 64, 320, 416)];
                    [self.adBanner setFrame:CGRectMake(0, 430, 320, 50)];
                }
                
            } else {
                
                //if ad is present
                if ((int)[[UIScreen mainScreen] bounds].size.height == 568) {
                    //4 inch
                    [self.webView setFrame:CGRectMake(0, 64, 320, 454)];
                    [self.backButton setFrame:CGRectMake(10, 477, 32, 29)];
                    [self.adBanner setFrame:CGRectMake(0, 518, 320, 50)];
                    [self.refreshButton setFrame:CGRectMake(281, 477, 32, 29)];
                    
                } else {
                    //3.5 inch
                    [self.backButton setFrame:CGRectMake(10, 394, 32, 29)];
                    [self.refreshButton setFrame:CGRectMake(281, 394, 32, 29)];
                    [self.webView setFrame:CGRectMake(0, 64, 320, 366)];
                    [self.adBanner setFrame:CGRectMake(0, 430, 320, 50)];
                }
                
            }
            
            
            
            
            
            
        } else {
            
            //if landscape
            
            int magicNumber = 52;
            
            if (![[SharedValues allValues] adIsLoaded]) {
                //if no ad present
                if ((int)[[UIScreen mainScreen] bounds].size.height == 568) {
                    //4 inch
                    [self.webView setFrame:CGRectMake(0, magicNumber, 568, 268)];
                    [self.backButton setFrame:CGRectMake(10, 283, 32, 29)];
                    [self.refreshButton setFrame:CGRectMake(530, 283, 32, 29)];
                    [self.adBanner setFrame:CGRectMake(0, 288, 568, 32)];
                    
                } else {
                    //3.5 inch
                    [self.webView setFrame:CGRectMake(0, magicNumber, 480, 268)];
                    [self.backButton setFrame:CGRectMake(10, 283, 32, 29)];
                    [self.refreshButton setFrame:CGRectMake(442, 283, 32, 29)];
                    [self.adBanner setFrame:CGRectMake(0, 288, 480, 32)];
                }
                
            } else {
                
                int magicNumber2 = 3;
                
                //if ad is present
                if ((int)[[UIScreen mainScreen] bounds].size.height == 568) {
                    //4 inch
                    [self.webView setFrame:CGRectMake(0, magicNumber, 568, 233 + magicNumber2)];
                    [self.backButton setFrame:CGRectMake(10, 248, 32, 29)];
                    [self.adBanner setFrame:CGRectMake(0, 288, 568, 32)];
                    [self.refreshButton setFrame:CGRectMake(530, 248, 32, 29)];
                    
                } else {
                    //3.5 inch
                    [self.backButton setFrame:CGRectMake(10, 248, 32, 29)];
                    [self.refreshButton setFrame:CGRectMake(442, 248, 32, 29)];
                    [self.webView setFrame:CGRectMake(0, magicNumber, 480, 233 + magicNumber2)];
                    [self.adBanner setFrame:CGRectMake(0, 288, 480, 32)];
                }
                
            }
            
            
            
            
            
            
        }
        
      
        
        
        
    } else {
        [self iPadOrientationSetUp];
    }
    
    [self.loadingAnimation setFrame:CGRectMake(CGRectGetMidX(self.view.bounds)-(self.loadingAnimation.frame.size.width / 2), CGRectGetMidY(self.view.bounds), self.loadingAnimation.frame.size.width, self.loadingAnimation.frame.size.height)];
    
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
    if ([[SharedValues allValues] adIsLoaded]) {
        [self.backButton setFrame:CGRectMake(self.backButton.frame.origin.x, self.backButton.frame.origin.y - 60, self.backButton.frame.size.width, self.backButton.frame.size.height)];
        [self.refreshButton setFrame:CGRectMake(self.refreshButton.frame.origin.x, self.refreshButton.frame.origin.y - 60, self.refreshButton.frame.size.width, self.refreshButton.frame.size.height)];
        [self.webView setFrame:CGRectMake(self.webView.frame.origin.x, self.webView.frame.origin.y, self.webView.frame.size.width, self.webView.frame.size.height - 66)];
        
    }

    
    
}

- (void)loadBanner {
    
    
    //show the ad regardless
    [self.adBanner setAlpha:1];
    [self viewDidLayoutSubviews];
}

- (void)bannerError {

    [self.adBanner setAlpha:0.0];
    [self viewDidLayoutSubviews];


}


@end
