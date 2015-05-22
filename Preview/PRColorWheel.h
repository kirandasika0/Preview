//
//  PRColorWheel.h
//  Preview
//
//  Created by SaiKiran Dasika on 22/05/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PRColorWheel : NSObject

@property (nonatomic, strong) NSArray *colors;

- (UIColor *)randomColor;

@end
