//
//  WebPageViewController.m
//  ELHS Sports
//
//  Created by Alex Atwater on 2/22/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "WebPageViewController.h"

@interface WebPageViewController ()

@end

@implementation WebPageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setAutomaticallyAdjustsScrollViewInsets:false];
    
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"\n%@", self.urlToLoad);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}




@end
