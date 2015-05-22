//
//  PRColorWheel.m
//  Preview
//
//  Created by SaiKiran Dasika on 22/05/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import "PRColorWheel.h"

@implementation PRColorWheel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _colors = [[NSArray alloc] initWithObjects:
                   [UIColor colorWithRed:80.0/255.0 green:208.0/255.0 blue:83.0/255.0 alpha:1],
                   [UIColor colorWithRed:133.0/255.0 green:218.0/255.0 blue:239.0/255.0 alpha:1],
                   [UIColor colorWithRed:255.0/255.0 green:158/255.0 blue:183.0/255.0 alpha:1],
                   [UIColor colorWithRed:143.0/255.0 green:148.0/255.0 blue:240.0/255.0 alpha:1], nil];
    }
    return self;
}

- (UIColor *)randomColor
{
    int random = arc4random_uniform((int)self.colors.count);
    
    return [self.colors objectAtIndex:random];
}

@end
