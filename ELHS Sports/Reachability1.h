//
//  Reachability.h
//  ELHS Sports
//
//  Created by Alex Atwater on 3/2/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Reachability : NSObject

+ (bool)checkForInternetWithSite:(BOOL)checkSite;
+ (UIAlertView *)showAlertNoInternetIsOffline:(BOOL)offline;


@end
