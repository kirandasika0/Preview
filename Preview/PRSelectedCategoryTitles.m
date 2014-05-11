//
//  PRSelectedCategoryTitles.m
//  Preview
//
//  Created by SaiKiran Dasika on 11/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRSelectedCategoryTitles.h"

@implementation PRSelectedCategoryTitles

- (id) initWithTitle:(NSString *)title {
    self = [super init];
    
    if ( self ){
        self.title = title;
        self.decp = nil;
    }
    
    return self;
}

+ (id) blogPostWithTitle:(NSString *)title {
    return [[self alloc] initWithTitle:title];
}

- (NSURL *) thumbnailURL {
    //    NSLog(@"%@",[self.thumbnail class]);
    return [NSURL URLWithString:self.thumbnail];
}

@end
