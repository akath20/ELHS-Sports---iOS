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
#import "Reachability.h"

@interface ViewController () 

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    //check for internet connection
    if (![Reachability checkForInternetWithString:Nil]) {
        //show alert from the class
        [[Reachability showAlertNoInternet] show];
    }
    
    
    
    //The ad
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadBanner) name:@"bannerLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bannerError) name:@"bannerError" object:nil];
    NSLog(@"\nSharedAdBannerView x: %f y:%f", SharedAdBannerView.frame.origin.x, SharedAdBannerView.frame.origin.y);
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
        [self iPadOrientationSetUp];
    }
    
    
    
    
    NSLog(@"\nSharedAdBannerView x: %f y:%f", SharedAdBannerView.frame.origin.x, SharedAdBannerView.frame.origin.y);
    
}

- (BOOL)shouldAutorotate {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        //iPhone
        return false;
    } else {
        //iPad
        return true;
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        //iPhone
        
        [self.adBanner setFrame:CGRectMake(0, 64, 320, 50)];
        
        if (!((int)[[UIScreen mainScreen] bounds].size.height == 568)) {
            //3.5 inch
        } else {
            //4 inch
            
        }
        
        //add the ad to the view
        
        if (SharedAdBannerView.isBannerLoaded) {
            [self loadBanner];
        } else {
            [self bannerError];
        }
        
        
    }
    
    
    [self.view addSubview:self.adBanner];
    
    
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
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
    //check for internet connection
    if (![Reachability checkForInternetWithString:Nil]) {
        //show alert from the class
        [[Reachability showAlertNoInternet] show];
    } else {
        [self performSegueWithIdentifier:@"showWebPage" sender:Nil];
    }
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"bannerLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"bannerError" object:nil];
}

- (void)iPadOrientationSetUp {
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) {
        //if portrait
        
        //set the buttons
        for (UIButton *currentButton in self.allButtons) {
            if ([currentButton.titleLabel.text isEqualToString:@"Basketball"]) {
                [currentButton setFrame:CGRectMake(140, 153, currentButton.frame.size.width, currentButton.frame.size.height)];
            } else if ([currentButton.titleLabel.text isEqualToString:@"Soccer"]) {
                [currentButton setFrame:CGRectMake(46, 431, currentButton.frame.size.width, currentButton.frame.size.height)];
            } else if ([currentButton.titleLabel.text isEqualToString:@"Skiing"]) {
                [currentButton setFrame:CGRectMake(51, 760, currentButton.frame.size.width, currentButton.frame.size.height)];
            } else if ([currentButton.titleLabel.text isEqualToString:@"Wrestling"]) {
                [currentButton setFrame:CGRectMake(291, 763, currentButton.frame.size.width, currentButton.frame.size.height)];
            } else if ([currentButton.titleLabel.text isEqualToString:@"Track"]) {
                [currentButton setFrame:CGRectMake(559, 770, currentButton.frame.size.width, currentButton.frame.size.height)];
            } else if ([currentButton.titleLabel.text isEqualToString:@"Hockey"]) {
                [currentButton setFrame:CGRectMake(570, 453, currentButton.frame.size.width, currentButton.frame.size.height)];
            } else if ([currentButton.titleLabel.text isEqualToString:@"Swimming"]) {
                [currentButton setFrame:CGRectMake(469, 155, currentButton.frame.size.width, currentButton.frame.size.height)];
            } else if ([currentButton.titleLabel.text isEqualToString:@"Home"]) {
                [currentButton setFrame:CGRectMake(244, 375, currentButton.frame.size.width, currentButton.frame.size.height)];
            } else {
                NSLog(@"\nError. ViewController -> iPadOrientationSetUp, portrait, buttons");
            }
        }
        
        //set the labels
        for (UILabel *currentLabel in self.allLabels) {
            if ([currentLabel.text isEqualToString:@"Basketball"]) {
                [currentLabel setFrame:CGRectMake(144, 324, currentLabel.frame.size.width, currentLabel.frame.size.height)];
            } else if ([currentLabel.text isEqualToString:@"Soccer"]) {
                [currentLabel setFrame:CGRectMake(68, 645, currentLabel.frame.size.width, currentLabel.frame.size.height)];
            } else if ([currentLabel.text isEqualToString:@"Skiing"]) {
                [currentLabel setFrame:CGRectMake(56, 908, currentLabel.frame.size.width, currentLabel.frame.size.height)];
            } else if ([currentLabel.text isEqualToString:@"Wrestling"]) {
                [currentLabel setFrame:CGRectMake(312, 915, currentLabel.frame.size.width, currentLabel.frame.size.height)];
            } else if ([currentLabel.text isEqualToString:@"Track"]) {
                [currentLabel setFrame:CGRectMake(585, 911, currentLabel.frame.size.width, currentLabel.frame.size.height)];
            } else if ([currentLabel.text isEqualToString:@"Hockey"]) {
                [currentLabel setFrame:CGRectMake(587, 646, currentLabel.frame.size.width, currentLabel.frame.size.height)];
            } else if ([currentLabel.text isEqualToString:@"Swimming & Diving"]) {
                [currentLabel setFrame:CGRectMake(458, 297, currentLabel.frame.size.width, currentLabel.frame.size.height)];
            } else if ([currentLabel.text isEqualToString:@"Home"]) {
                [currentLabel setFrame:CGRectMake(331, 656, currentLabel.frame.size.width, currentLabel.frame.size.height)];
            } else {
                NSLog(@"\nError. ViewController -> iPadOrientationSetUp, portrait, labels");
            }
        }
        
        
        //set the ad frame
        [self.adBanner setFrame:CGRectMake(0, 64, 768, 66)];
        
        
    } else {
        //if landscape
        
        //set the buttons
        for (UIButton *currentButton in self.allButtons) {
            if ([currentButton.titleLabel.text isEqualToString:@"Basketball"]) {
                [currentButton setFrame:CGRectMake(110, 141, currentButton.frame.size.width, currentButton.frame.size.height)];
            } else if ([currentButton.titleLabel.text isEqualToString:@"Soccer"]) {
                [currentButton setFrame:CGRectMake(111, 372, currentButton.frame.size.width, currentButton.frame.size.height)];
            } else if ([currentButton.titleLabel.text isEqualToString:@"Skiing"]) {
                [currentButton setFrame:CGRectMake(123, 571, currentButton.frame.size.width, currentButton.frame.size.height)];
            } else if ([currentButton.titleLabel.text isEqualToString:@"Wrestling"]) {
                [currentButton setFrame:CGRectMake(419, 575, currentButton.frame.size.width, currentButton.frame.size.height)];
            } else if ([currentButton.titleLabel.text isEqualToString:@"Track"]) {
                [currentButton setFrame:CGRectMake(749, 581, currentButton.frame.size.width, currentButton.frame.size.height)];
            } else if ([currentButton.titleLabel.text isEqualToString:@"Hockey"]) {
                [currentButton setFrame:CGRectMake(760, 372, currentButton.frame.size.width, currentButton.frame.size.height)];
            } else if ([currentButton.titleLabel.text isEqualToString:@"Swimming"]) {
                [currentButton setFrame:CGRectMake(756, 141, currentButton.frame.size.width, currentButton.frame.size.height)];
            } else if ([currentButton.titleLabel.text isEqualToString:@"Home"]) {
                [currentButton setFrame:CGRectMake(372, 181, currentButton.frame.size.width, currentButton.frame.size.height)];
            } else {
                NSLog(@"\nError. ViewController -> iPadOrientationSetUp, portrait, buttons");
            }
        }
        
        //set the labels
        for (UILabel *currentLabel in self.allLabels) {
            if ([currentLabel.text isEqualToString:@"Basketball"]) {
                [currentLabel setFrame:CGRectMake(114, 309, currentLabel.frame.size.width, currentLabel.frame.size.height)];
            } else if ([currentLabel.text isEqualToString:@"Soccer"]) {
                [currentLabel setFrame:CGRectMake(133, 514, currentLabel.frame.size.width, currentLabel.frame.size.height)];
            } else if ([currentLabel.text isEqualToString:@"Skiing"]) {
                [currentLabel setFrame:CGRectMake(137, 719, currentLabel.frame.size.width, currentLabel.frame.size.height)];
            } else if ([currentLabel.text isEqualToString:@"Wrestling"]) {
                [currentLabel setFrame:CGRectMake(440, 723, currentLabel.frame.size.width, currentLabel.frame.size.height)];
            } else if ([currentLabel.text isEqualToString:@"Track"]) {
                [currentLabel setFrame:CGRectMake(773, 719, currentLabel.frame.size.width, currentLabel.frame.size.height)];
            } else if ([currentLabel.text isEqualToString:@"Hockey"]) {
                [currentLabel setFrame:CGRectMake(777, 515, currentLabel.frame.size.width, currentLabel.frame.size.height)];
            } else if ([currentLabel.text isEqualToString:@"Swimming & Diving"]) {
                [currentLabel setFrame:CGRectMake(745, 282, currentLabel.frame.size.width, currentLabel.frame.size.height)];
            } else if ([currentLabel.text isEqualToString:@"Home"]) {
                [currentLabel setFrame:CGRectMake(459, 525, currentLabel.frame.size.width, currentLabel.frame.size.height)];
            } else {
                NSLog(@"\nError. ViewController -> iPadOrientationSetUp, portrait, labels");
            }
        }
        
        
        //set the ad frame
        [self.adBanner setFrame:CGRectMake(0, 62, 1024, 66)];

        
    }
    
    
    
    
    
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        //iPhone
        return UIInterfaceOrientationPortrait;
    } else {
        //iPad
        return UIInterfaceOrientationLandscapeLeft + UIInterfaceOrientationLandscapeRight + UIInterfaceOrientationPortrait + UIInterfaceOrientationPortraitUpsideDown;
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
