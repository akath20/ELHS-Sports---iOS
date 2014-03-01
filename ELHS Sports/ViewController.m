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

@implementation ViewController {
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    
    
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadBanner) name:@"bannerLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bannerError) name:@"bannerError" object:nil];
    
    
    self.adBanner = SharedAdBannerView;
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        //iPhone
        
        [self.adBanner setFrame:CGRectMake(0, 64, 320, 50)];
        
        if (!((int)[[UIScreen mainScreen] bounds].size.height == 568)) {
            
            int magicNumber = 25;
            int modNumber = 15;
            float xMove  =.5;
            
            
            
            for (UIButton *currentButton in [self allButtons]) {
                if (currentButton.tag == 1) {
                    //top line
                    [currentButton setFrame:CGRectMake(currentButton.frame.origin.x, (currentButton.frame.origin.y - magicNumber  + modNumber), (currentButton.frame.size.width - magicNumber), (currentButton.frame.size.height - magicNumber))];
                } else if (currentButton.tag == 2) {
                    //bottem line
                    [currentButton setFrame:CGRectMake(currentButton.frame.origin.x, (currentButton.frame.origin.y - magicNumber - modNumber), (currentButton.frame.size.width - magicNumber), (currentButton.frame.size.height - magicNumber))];
                } else {
                    //middle line
                    [currentButton setFrame:CGRectMake(currentButton.frame.origin.x, (currentButton.frame.origin.y - magicNumber), (currentButton.frame.size.width - magicNumber), (currentButton.frame.size.height - magicNumber))];
                }
                
                [currentButton setFrame:CGRectMake((currentButton.frame.origin.x + (magicNumber * xMove)), currentButton.frame.origin.y, currentButton.frame.size.width, currentButton.frame.size.height)];
                
            }
            
            for (UILabel *currentLabel in [self allLabels]) {
                
                
                
                
                if (currentLabel.tag == 1) {
                    //top line
                    [currentLabel setFrame:CGRectMake(currentLabel.frame.origin.x, (currentLabel.frame.origin.y - (magicNumber * 1.75) + (modNumber  * .75)), currentLabel.frame.size.width, currentLabel.frame.size.height)];
                } else if (currentLabel.tag == 2) {
                    //bottem line
                    [currentLabel setFrame:CGRectMake(currentLabel.frame.origin.x, (currentLabel.frame.origin.y - (magicNumber * 1.75) - (modNumber  * .75)), currentLabel.frame.size.width, currentLabel.frame.size.height)];
                } else {
                    //middle line
                    [currentLabel setFrame:CGRectMake(currentLabel.frame.origin.x, (currentLabel.frame.origin.y - (magicNumber * 1.75)), currentLabel.frame.size.width, currentLabel.frame.size.height)];
                }
                
                
                
                
            }
            
        }
    } else {
        //iPad
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    [self.view addSubview:self.adBanner];
    
    //hide the ad
    
    
    
    
    
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
        [self.adBanner setAlpha:1];
    }
    
}

- (void)bannerError {
    if (self.adBanner.alpha > 0) {
        [self.adBanner setAlpha:0];
    }
    
}










@end
