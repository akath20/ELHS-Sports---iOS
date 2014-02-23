//
//  WebPageViewController.m
//  ELHS Sports
//
//  Created by Alex Atwater on 2/22/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "WebPageViewController.h"
#import "SharedValues.h"

@interface WebPageViewController ()

@end

@implementation WebPageViewController


- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setAutomaticallyAdjustsScrollViewInsets:false];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    //Setup The Web View
    [self setupTheWebView];
    
    //set the title of the nav bar
    if ([[[SharedValues allValues] urlToLoadAsString] isEqualToString:@""]) {
        self.topNavBar.title = @"Home";
    } else {
        self.topNavBar.title = [[SharedValues allValues] urlToLoadAsString];
    }
    
    
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)setupTheWebView {
    
    //get the webpage to load
    NSString *urlToLoadAsString = [[SharedValues allValues] urlToLoadAsString];
    
    //convert to URL
    NSURL *urlToLoadAsURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://www.eastlongmeadowsports.com/%@", urlToLoadAsString]];
    
    //make a load request
    NSURLRequest *urlToLoadRequest = [[NSURLRequest alloc] initWithURL:urlToLoadAsURL];
    
    //load the webpage
    [self.webView loadRequest:urlToLoadRequest];
    
}



@end
