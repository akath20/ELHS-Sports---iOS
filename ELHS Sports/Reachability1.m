//
//  Reachability.m
//  ELHS Sports
//
//  Created by Alex Atwater on 3/2/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "Reachability.h"

@implementation Reachability

+ (bool)checkForInternetWithSite:(BOOL)checkSite {
    
    __block BOOL internetAvailable;
    
    
//    
//    if (checkSite) {
//        //if we want to check eastlongmeadowsports.com
//        NSURL *scriptUrl = [NSURL URLWithString:@"http://www.eastlongmeadowsports.typepad.com/elsportsaboutpage/"];
//        NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
//        if (data) {
//            //connected to the internet
//            internetAvailable = YES;
//        } else {
//            //not connected to the internet
//            internetAvailable = NO;
//        }
//        
//    } else {
//        NSURL *scriptUrl = [NSURL URLWithString:@"http://www.google.com"];
//        NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
//        if (data) {
//            //connected to the internet
//            internetAvailable = YES;
//        } else {
//            //not connected to the internet
//            internetAvailable = NO;
//        }
//    }
    
    
    
    NSString *connect = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://google.com"] encoding:NSUTF8StringEncoding error:nil];
    
    if (connect == NULL) {
        //When there isn't internet
        internetAvailable = false;
    }
    else {
        //When there is
        internetAvailable = true;
    }
    
    
    
    
//    //rewrite of this method
//    NSURL *scriptUrl;
//    if (checkSite) {
//        scriptUrl = [NSURL URLWithString:@"http://www.eastlongmeadowsports.typepad.com/elsportsaboutpage/"];
//    } else {
//        scriptUrl = [NSURL URLWithString:@"http://www.google.com"];
//    }
//    
//    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
//    defaultConfigObject.timeoutIntervalForRequest = 15;
//    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject];
//    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithURL:scriptUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        //error code here
//        if (error) {
//            NSLog(@"\nDownload Error: %@", error);
//            internetAvailable = false;
//
//        } else {
//            internetAvailable = true;
//        }
//        
//        
//    }];
//    
//    
//    
//    
//    //start
//    [dataTask resume];
    
    
    
    return internetAvailable;
}



+ (UIAlertView *)showAlertNoInternetIsOffline:(BOOL)offline {
    
    UIAlertView *alert;
    
    if (offline) {
        //if no internet can be reached by google
        
        alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"An internet connection couldn't be established. Please connect to the internet and try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    } else {
        //if the website is down
        alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Eastlongmeadowsports.com appears to be offline. Please check back later." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    }
    
    return alert;
    
}


@end
