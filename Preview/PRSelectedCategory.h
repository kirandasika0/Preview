//
//  PRSelectedCategory.h
//  Preview
//
//  Created by SaiKiran Dasika on 21/11/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRSelectedCategory : NSObject {
    NSString *category;
    NSString *productName;
    NSString *productRating;
}

@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *productName;
@property (strong, nonatomic) NSString *productRating;

+ (id)productOfCategory:(NSString*)category name:(NSString*)name rating:(NSString *)rating;

@end
