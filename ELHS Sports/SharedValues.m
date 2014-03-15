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
    
    
    NSDictionary *home = [[NSDictionary alloc] initWithObjectsAndKeys:@"Home", @"Title", nil];
    
    NSDictionary *soccer = [[NSDictionary alloc] initWithObjectsAndKeys:@"Soccer", @"Title", nil];
    
    NSDictionary *basketball = [[NSDictionary alloc] initWithObjectsAndKeys:@"Basketball", @"Title", nil];
    
    NSDictionary *skiing = [[NSDictionary alloc] initWithObjectsAndKeys:@"Skiing", @"Title", nil];
    
    NSDictionary *wrestling = [[NSDictionary alloc] initWithObjectsAndKeys:@"Wrestling", @"Title", nil];
    
    NSDictionary *swimming = [[NSDictionary alloc] initWithObjectsAndKeys:@"Swimming & Diving", @"Title", nil];
    
    NSDictionary *hockey = [[NSDictionary alloc] initWithObjectsAndKeys:@"Hockey", @"Title", nil];
    
    NSDictionary *track = [[NSDictionary alloc] initWithObjectsAndKeys:@"Track", @"Title", nil];
    
    NSArray *allSports = [[NSArray alloc] initWithObjects:home, soccer, basketball, skiing, wrestling, swimming, hockey, track, nil];
    
    self.sharedTableContent = [[NSArray alloc] initWithArray:allSports copyItems:true];
}


@end
