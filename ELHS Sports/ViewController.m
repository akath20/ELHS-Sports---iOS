//
//  ViewController.m
//  ELHS Sports
//
//  Created by Alex Atwater on 2/22/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "ViewController.h"
#import "SharedValues.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    if (!((int)[[UIScreen mainScreen] bounds].size.height == 568)) {
        
        int magicNumber = 20;
        
        for (UIButton *currentButton in [self allButtons]) {
            [currentButton setFrame:CGRectMake(currentButton.frame.origin.x, (currentButton.frame.origin.y - magicNumber), currentButton.frame.size.width, currentButton.frame.size.height)];
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


@end
