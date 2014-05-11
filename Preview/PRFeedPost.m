//
//  PRFeedPost.m
//  Preview
//
//  Created by SaiKiran Dasika on 10/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRFeedPost.h"

@implementation PRFeedPost

- (id) initWithTitle:(NSString *)title {
    self = [super init];
    
    if ( self ){
        self.title = title;
        self.category = nil;
        self.thumbnail = nil;
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
