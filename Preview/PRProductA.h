//
//  PRProductA.h
//  Preview
//
//  Created by SaiKiran Dasika on 22/07/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRProductA : NSObject
-(NSDictionary *)checkInstaceTypeAndProvideInformation:(NSString *)type;
-(void)calculateNewBaseRatingForProductAWithId:(NSInteger)productAId andProductABaseRating:(CGFloat)productABaseRating andForProductBWithId:(NSInteger)productBId andProductBBaseRating:(CGFloat)productBBaseRating;
-(CGFloat)getNewProductBaseRating;

@property (strong, nonatomic) NSDictionary *productInformation;
@property (nonatomic) CGFloat newBaseRating;
@end
