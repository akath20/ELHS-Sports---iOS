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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
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
    } else if ([selectedSport isEqualToString:@"Ski"]) {
        [[SharedValues allValues] setUrlToLoadAsString:@"Ski"];
    } else if ([selectedSport isEqualToString:@"Track"]) {
        [[SharedValues allValues] setUrlToLoadAsString:@"Track"];
    } else {
        NSLog(@"Error; Bad title for button.");
    }
    
    
    //switch the view
    [self performSegueWithIdentifier:@"showWebPage" sender:Nil];
}


@end
