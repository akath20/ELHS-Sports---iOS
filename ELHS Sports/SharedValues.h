//
//  SharedValues.h
//  ELHS Sports
//
//  Created by Alex Atwater on 2/22/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedValues : NSObject

@property (strong, nonatomic) NSString *urlToLoadAsString;
@property BOOL webViewDidLoadOnce;

+ (SharedValues *)allValues;


@end
