//
//  PRProductA.m
//  Preview
//
//  Created by SaiKiran Dasika on 22/07/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import "PRProductA.h"
#import "AFNetworking.h"

//constants
#define K_FACTOR 30
#define K_FACTOR_15 15
@implementation PRProductA

-(id)init{
    
    self = [super init];
    return self;
}

-(NSDictionary *)checkInstaceTypeAndProvideInformation:(NSString *)type{
    static NSDictionary *responseDictionary;
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    if ([type isEqualToString:@"init"]) {
        responseDictionary = [self getProduct];
        dispatch_semaphore_signal(sem);
    }
    
    
    return responseDictionary;
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
}

-(NSDictionary *)getProduct{
    //creating a semaphore
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    static NSDictionary *responseDictionary = nil;
    NSURL *url = [NSURL URLWithString:@"http://burst.co.in/preview/GetProduct.php?cat=1"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data.length > 0 && connectionError == nil && data != nil) {
            responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            //NSLog(@"%@", responseDictionary);
            //incrementing the value of the the semaphore
            self.productInformation = responseDictionary;
            dispatch_semaphore_signal(sem);
        }
    }];
    return responseDictionary;
    //decremening the value of the semaphore
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER); //waiting for the network request to complete
}

-(void)calculateNewBaseRatingForProductAWithId:(NSInteger)productAId andProductABaseRating:(CGFloat)productABaseRating andForProductBWithId:(NSInteger)productBId andProductBBaseRating:(CGFloat)productBBaseRating{
    NSLog(@"=====================================");
    //sending a test request
    //for a
    //expected value of a after winning the game
    //expected value cannot exceed 1 as it's the probablity
    //and probabilty cannot exceed 1
    CGFloat Ea = 1/(1 + pow(10, (productBBaseRating - productABaseRating)/400));
    
    //New base rating
    //sa will be 1
    CGFloat Rdiffa = productABaseRating + K_FACTOR*(1 - Ea);
    self.newBaseRating = Rdiffa;
    //NSLog(@"New rating for a: %f", Rdiffa);
    
    //for b
    CGFloat Eb = 1/(1 + pow(10, (productABaseRating - productBBaseRating) / 400));
    
    CGFloat Rdiffb = productBBaseRating + K_FACTOR*(0 - Eb);
    
    //NSLog(@"New rating for b: %f", Rdiffb);
    
    //we are sending a network request to save all the changes in the database
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"producta_id": [NSString stringWithFormat:@"%ld", productAId], @"producta_rating": [NSString stringWithFormat:@"%.4f", Rdiffa], @"productb_id": [NSString stringWithFormat:@"%ld", productBId], @"productb_rating": [NSString stringWithFormat:@"%.4f", Rdiffb]};
    [manager POST:@"http://burst.co.in/preview/UpdateRatings.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(CGFloat)getNewProductBaseRating{
    return self.newBaseRating;
}

-(NSInteger)getNewRounds{
    return  self.newRounds;
}



@end
