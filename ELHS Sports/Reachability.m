//
//  Reachability.m
//  ELHS Sports
//
//  Created by Alex Atwater on 3/2/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "Reachability.h"

@implementation Reachability

+ (bool)checkForInternetWithString:(NSString *)stringToCheck {
    
    BOOL internetAvailable;
    
    if (stringToCheck) {
        //if there is a string to check
        NSURL *scriptUrl = [NSURL URLWithString:stringToCheck];
        NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
        if (data) {
            //connected to the internet
            internetAvailable = YES;
        } else {
            //not connected to the internet
            internetAvailable = NO;
        }
        
    } else {
        NSURL *scriptUrl = [NSURL URLWithString:@"http://www.google.com"];
        NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
        if (data) {
            //connected to the internet
            internetAvailable = YES;
        } else {
            //not connected to the internet
            internetAvailable = NO;
        }
    }
    
    
    return internetAvailable;
}

+ (UIAlertView *)showAlertNoInternet {
    UIAlertView *noInternetAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"An internet connection couldn't be established. Please connect to the internet and try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    return noInternetAlert;
    
}


@end
