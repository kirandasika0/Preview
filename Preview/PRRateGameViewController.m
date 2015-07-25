//
//  PRRateGameViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 27/04/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import "PRRateGameViewController.h"
#import "PRColorWheel.h"
#import "UIImageEffects.h"


@interface PRRateGameViewController ()

@end

@implementation PRRateGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.productAView.alpha = 0.2;
    self.productBView.alpha = 0.2;
    [self.playGameButton setHidden:NO];
    
    self.sampleProductAInstance = [[PRProductA alloc] init];
    
    //setting the product's image view's nil to make sure we can proceed with alorithm.
    UITapGestureRecognizer *tapForProductA = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapForProductA)];
    tapForProductA.numberOfTapsRequired = 1;
    [self.productAView addGestureRecognizer:tapForProductA];
    
    UITapGestureRecognizer *tapForProductB = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapForProductB)];
    tapForProductB.numberOfTapsRequired = 1;
    [self.productBView addGestureRecognizer:tapForProductB];
}

-(void)getAndSetProductAInformation{
    PRProductA *productA = [[PRProductA alloc] init];
    self.productAInformation = [productA checkInstaceTypeAndProvideInformation:@"init"];
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        if (self.productAInformation != NULL) {
            self.productName.text = self.productAInformation[@"product_name"];
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(queue, ^{
                NSData *productAImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.productAInformation[@"image_full_size"]]];
                if (productAImageData != nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImage *productAImage = [UIImage imageWithData:productAImageData];
                        self.productAImageView.image = productAImage;
                    });
                }
            });
        }
        else{
            [self.tabBarController setSelectedIndex:0];
        }
            
    });
}


-(void)getAndSetProductBInformation{
    PRProductB *productB = [[PRProductB alloc] init];
    self.productBInformation = [productB checkInstanceTypeAndGetInformation:@"init"];
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        if (self.productBInformation != NULL) {
            self.productBNameLabel.text = self.productBInformation[@"product_name"];
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(queue, ^{
                NSData *productBImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.productBInformation[@"image_full_size"]]];
                if (productBImageData != nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImage *productBImage = [UIImage imageWithData:productBImageData];
                        self.productBImageView.image = productBImage;
                    });
                }
            });
        }
        else{
            [self.tabBarController setSelectedIndex:0];
        }
    });
}



#pragma mark - IBactions

- (IBAction)playGame:(id)sender {
    [UIView animateWithDuration:1.5 animations:^{
        self.productAView.alpha = 1.0;
        self.productBView.alpha = 1.0;
        [self.playGameButton setHidden:YES];
    }];
    //getting and setting product a information
    [self getAndSetProductAInformation];
    [self getAndSetProductBInformation];
    NSLog(@"%@", self.productAInformation[@"product_name"]);
    NSLog(@"%@", self.productBInformation[@"product_name"]);
}



#pragma mark - Gesture Handling

-(void)handleTapForProductA{
    //which means A has won
    PRProductA *productA = [[PRProductA alloc] init];
    [productA calculateNewBaseRatingForProductAWithId:[self getProductAId] andProductABaseRating:[self getBaseRatingForProductA] andForProductBWithId:[self getProductBId] andProductBBaseRating:[self getBaseRatingForProductB]];
    NSLog(@"New base rating from rate view controller: %f", [productA getNewProductBaseRating]);
    NSMutableDictionary *tempMutableDictionary = [[NSMutableDictionary alloc] initWithDictionary:self.productAInformation];
    tempMutableDictionary[@"base_rating"] = [NSString stringWithFormat:@"%f", [productA getNewProductBaseRating]];
    self.productAInformation = tempMutableDictionary;
    [self getAndSetProductBInformation];
}

-(void)handleTapForProductB{
    //which means b has won
    PRProductB *productB = [[PRProductB alloc] init];
    //calculating the new base rating below
    [productB calculateNewBaseRatingWithProductBId:[self getProductBId] andProductBBaseRating:[self getBaseRatingForProductB] andForProductAWithId:[self getProductAId] andProductABaseRating:[self getBaseRatingForProductA]];
    
    //making a temp dictionary because we have to update the rating and put that back in the property productBInformation
    NSMutableDictionary *tempDictinary = [[NSMutableDictionary alloc] initWithDictionary: self.productBInformation];
    tempDictinary[@"base_rating"] = [NSString stringWithFormat:@"%f", [productB getNewProductBaseRating]];
    self.productBInformation = tempDictinary;
    [self getAndSetProductAInformation];
}


#pragma mark - Getter Methods for product A
-(NSString *)getProductNameForProductA{
    return self.productAInformation[@"product_name"];
}

-(CGFloat)getBaseRatingForProductA{
    CGFloat baseRating = 0.0;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    baseRating = [formatter numberFromString:self.productAInformation[@"base_rating"]].floatValue;
    
    return baseRating;
}

-(NSInteger)getNumOfRoundsForProductA{
    NSInteger rounds = 0;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    rounds = [formatter numberFromString:self.productAInformation[@"rounds"]].integerValue;
    return rounds;
}

-(NSInteger)getProductAId{
    NSInteger productId = 0;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    productId = [formatter numberFromString:self.productAInformation[@"id"]].integerValue;
    return productId;
}

#pragma mark - Getter Methods for Product B

-(CGFloat)getBaseRatingForProductB{
    CGFloat baseRating = 0.0;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    baseRating = [formatter numberFromString:self.productBInformation[@"base_rating"]].floatValue;
    return baseRating;
}

-(NSInteger)getNumOfRoundForProductB{
    //method returns a rouhds that are completed by the product.
    NSInteger rounds = 0;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    rounds = [formatter numberFromString:self.productBInformation[@"rounds"]].integerValue; // this makes the string value to integer
    return rounds;
}

-(NSInteger)getProductBId{
    NSInteger productId = 0;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    productId = [formatter numberFromString:self.productBInformation[@"id"]].integerValue;
    return productId;
}


@end
