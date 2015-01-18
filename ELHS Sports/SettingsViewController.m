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
#import <sys/utsname.h>

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
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        //iPhone
        
        [self.adBanner setFrame:CGRectMake(0, 64, 320, 50)];
        
        //the ad
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadBanner) name:@"bannerLoaded" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bannerError) name:@"bannerError" object:nil];
        self.adBanner = SharedAdBannerView;
        
    } else {
        //iPad
        
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        //iPhone
        
        //add the ad to the view
        [self.view addSubview:self.adBanner];
        if (SharedAdBannerView.isBannerLoaded) {
            [self loadBanner];
        } else {
            [self bannerError];
        }
        
        
    }
    
    
}



- (IBAction)launchWebsite:(id)sender {
    
    //load the string
    [[SharedValues allValues] setUrlToLoadAsString:@"http://webpages.charter.net/akath20/"];
    
    //switch the view
    //check for internet connection

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

- (IBAction)sendDevEmail:(UIButton *)sender {
   
        
    MFMailComposeViewController *emailSheet = [[MFMailComposeViewController alloc] init];
    
    emailSheet.mailComposeDelegate = self;
    
    // Fill out the email body text.
    
    //get the device type
    //*IMPORT* <sys/utsname.h>
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceType = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    
    
    NSString *emailBody = [NSString stringWithFormat:@"\n\r\n\r\n\riOS Version: %@\n\rDevice: %@\n\rApp Version: %@\n\rApp Name: %@", [[UIDevice currentDevice] systemVersion], deviceType, [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"], [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]];
    [emailSheet setMessageBody:emailBody isHTML:NO];
    [emailSheet setToRecipients:[NSArray arrayWithObject:@"akath20developer@gmail.com"]];

    
    // Present the mail composition interface.
    [self presentViewController:emailSheet animated:true completion:nil];
        
        
    

    
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:true completion:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"bannerLoaded" object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"bannerError" object:nil];
    }
    
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
