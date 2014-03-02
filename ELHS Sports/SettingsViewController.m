//
//  SettingsViewController.m
//  ELHS Sports
//
//  Created by Alex Atwater on 2/27/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "SettingsViewController.h"
#import "SharedValues.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController


- (void)viewDidLoad {
 
    
    //version number
    self.versionLabel.text = [NSString stringWithFormat:@"Version: %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    
    //set the frame if i move it
    [self.contentView setFrame:CGRectMake(0, 0, 320, self.contentView.frame.size.height)];
    
    //set the content size
    [self.scrollView setContentSize:self.contentView.frame.size];
    
    
    
}

- (IBAction)launchWebsite:(id)sender {
//    //open my website
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://webpages.charter.net/akath20/"]];
    
    //keep them in the app to load ads
    //load the string
    [[SharedValues allValues] setUrlToLoadAsString:@"http://webpages.charter.net/akath20/"];
    
    //switch the view
    [self performSegueWithIdentifier:@"showMyWebsite" sender:Nil];

}


@end
