//
//  PRProductB.h
//  Preview
//
//  Created by SaiKiran Dasika on 22/07/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRProductB : NSObject
-(CGFloat)calculateNewBaseWithCurrentBaseRating:(CGFloat)baseRating;
-(NSDictionary *)checkInstanceTypeAndGetInformation:(NSString *)type;
-(void)calculateNewBaseRatingWithProductBId:(NSInteger)productBId andProductBBaseRating:(CGFloat)productBBaseRating andForProductAWithId:(NSInteger)productAId andProductABaseRating:(CGFloat)productABaseRating;
-(CGFloat)getNewProductBaseRating;

@property (nonatomic) CGFloat newBaseRating;
@end
