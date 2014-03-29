//
//  SharedValues.m
//  ELHS Sports
//
//  Created by Alex Atwater on 2/22/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "SharedValues.h"

@implementation SharedValues

//IF THERE IS AN ERROR, IMPLEMENT THE ALLOCWITHZONE METHOD FROM FINALSCALCULATOR



+ (SharedValues *)allValues {
    
    static SharedValues *allValues;
    if (!allValues) {
        allValues = [[super allocWithZone:nil] init];
    }
    
    return allValues;
    
}

- (void)createSharedTableContent {
    
    //Initial
    NSDictionary *home = [[NSDictionary alloc] initWithObjectsAndKeys:@"Home", @"Title", [UIImage imageNamed:@"Home"], @"image", nil];
    
    NSDictionary *soccer = [[NSDictionary alloc] initWithObjectsAndKeys:@"Soccer", @"Title", [UIImage imageNamed:@"Soccer"], @"image", nil];
    
    NSDictionary *basketball = [[NSDictionary alloc] initWithObjectsAndKeys:@"Basketball", @"Title", [UIImage imageNamed:@"Basketball"], @"image", nil];
    
    NSDictionary *skiing = [[NSDictionary alloc] initWithObjectsAndKeys:@"Skiing", @"Title", [UIImage imageNamed:@"Ski"], @"image", nil];
    
    NSDictionary *wrestling = [[NSDictionary alloc] initWithObjectsAndKeys:@"Wrestling", @"Title", [UIImage imageNamed:@"Wrestling"], @"image", nil];
    
    NSDictionary *swimming = [[NSDictionary alloc] initWithObjectsAndKeys:@"Swimming & Diving", @"Title", [UIImage imageNamed:@"Swim"], @"image", nil];
    
    NSDictionary *hockey = [[NSDictionary alloc] initWithObjectsAndKeys:@"Hockey", @"Title", [UIImage imageNamed:@"Hockey"], @"image", nil];
    
    NSDictionary *track = [[NSDictionary alloc] initWithObjectsAndKeys:@"Track", @"Title", [UIImage imageNamed:@"Track"], @"image", nil];
    
    
    
    //New Sports added 3/29/14
    NSDictionary *baseball = [[NSDictionary alloc] initWithObjectsAndKeys:@"Baseball", @"Title", [UIImage imageNamed:@"Baseball"], @"image", nil];
    
    NSDictionary *lacrosse = [[NSDictionary alloc] initWithObjectsAndKeys:@"Lacrosse", @"Title", [UIImage imageNamed:@"Lacrosse"], @"image", nil];
    
        //Softball will just use the baseball picture
    NSDictionary *softball = [[NSDictionary alloc] initWithObjectsAndKeys:@"Softball", @"Title", [UIImage imageNamed:@"Baseball"], @"image", nil];
    
    NSDictionary *tennis = [[NSDictionary alloc] initWithObjectsAndKeys:@"Tennis", @"Title", [UIImage imageNamed:@"Tennis"], @"image", nil];
    
    NSDictionary *volleyball = [[NSDictionary alloc] initWithObjectsAndKeys:@"Volleyball", @"Title", [UIImage imageNamed:@"Volleyball"], @"image", nil];
    
    
    //add for rest of app
    NSArray *allSports = [[NSArray alloc] initWithObjects:home, baseball, basketball, hockey, lacrosse, skiing, soccer, softball, swimming, tennis, track, volleyball, wrestling, nil];
    
    self.sharedTableContent = [[NSArray alloc] initWithArray:allSports copyItems:true];
}


@end
