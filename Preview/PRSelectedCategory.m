//
//  PRSelectedCategory.m
//  Preview
//
//  Created by SaiKiran Dasika on 21/11/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRSelectedCategory.h"

@implementation PRSelectedCategory
@synthesize productName;
@synthesize productRating;
@synthesize category;

+(id)productOfCategory:(NSString *)category name:(NSString *)name rating:(NSString *)rating{
    PRSelectedCategory *newProduct = [[self alloc] init];
    newProduct.category = category;
    newProduct.productName = name;
    newProduct.productRating = rating;
    
    return newProduct;
}


@end
