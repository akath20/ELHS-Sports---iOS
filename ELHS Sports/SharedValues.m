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


@end
