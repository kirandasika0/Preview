//
//  PRSelectedCategoryTitles.h
//  Preview
//
//  Created by SaiKiran Dasika on 11/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRSelectedCategoryTitles : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic,strong) NSString *thumbnail;
@property (nonatomic,strong) NSString *rating;
@property (nonatomic,strong) NSString *decp;

//We have to call in the methods

- (id) initWithTitle:(NSString *)title;
+ (id) blogPostWithTitle:(NSString *)title;

- (NSURL *) thumbnailURL;

@end
