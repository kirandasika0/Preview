//
//  PRCategoryTitles.h
//  Preview
//
//  Created by SaiKiran Dasika on 10/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRCategoryTitles : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic,strong) NSString *emitterURL;

- (id) initWithTitle:(NSString *)title;
+ (id) blogPostWithTitle:(NSString *)title;


- (NSURL *) thumbnailURL;

@end
