//
//  PRProductB.m
//  Preview
//
//  Created by SaiKiran Dasika on 22/07/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import "PRProductB.h"
#import "AFNetworking.h"

#pragma mark - All K-FACTOR'S

#define K_FACTOR_OF_30 30

@implementation PRProductB
-(id)init{
    self = [super init];
    
    return self;
}
-(NSDictionary *)checkInstanceTypeAndGetInformation:(NSString *)type{
    static NSDictionary *responseDictionary = nil;
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    if ([type isEqualToString:@"init"]) {
        responseDictionary = [self getProduct];
        dispatch_semaphore_signal(sem);
    }
    return responseDictionary;
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
}

-(NSDictionary *)getProduct{
    static NSDictionary *responseDictionary;
    NSURL *url = [NSURL URLWithString:@"http://burst.co.in/preview/GetProduct.php?cat=1"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data.length > 0 && connectionError == nil) {
            responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        }
    }];
    return responseDictionary;
}

-(CGFloat)calculateNewBaseWithCurrentBaseRating:(CGFloat)baseRating{
    CGFloat newBaseRating = 1400;
    
    return newBaseRating;
}

-(void)calculateNewBaseRatingWithProductBId:(NSInteger)productBId andProductBBaseRating:(CGFloat)productBBaseRating andForProductAWithId:(NSInteger)productAId andProductABaseRating:(CGFloat)productABaseRating{
    NSLog(@"==================================="); //this is only for logging gui
    //this case b has won the match
    //caculating Eb first because it has won
    NSLog(@"Before Decrement: %f", productBBaseRating);
    CGFloat Eb = 1 / (1 + pow(10, (productABaseRating - productBBaseRating) / 400));
    
    //new base rating
    CGFloat Rdiffb = productBBaseRating + K_FACTOR_OF_30*(1 - Eb); //new rating for product b
    
    self.newBaseRating = Rdiffb;
    
    NSLog(@"New value of b is: %f", Rdiffb);
    
    
    //calculating for a
    CGFloat Ea = 1 / ( 1 + pow(10, (productBBaseRating - productABaseRating) / 400));
    CGFloat Rdiffa = productABaseRating + K_FACTOR_OF_30*(0 - Ea); //new rating for product a
    
    NSLog(@"New value of a: %f", Rdiffa);
    
    //sending network request for saving changes in the database
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"producta_id": [NSString stringWithFormat:@"%ld", productAId], @"producta_rating": [NSString stringWithFormat:@"%f", Rdiffa], @"productb_id": [NSString stringWithFormat:@"%ld", productBId], @"productb_rating": [NSString stringWithFormat:@"%f", Rdiffb]};
    [manager POST:@"http://burst.co.in/preview/UpdateRatings.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

-(CGFloat)getNewProductBaseRating{
    return self.newBaseRating;
}
@end
