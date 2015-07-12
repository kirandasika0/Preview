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
    
    
    //setting the product's image view's nil to make sure we can proceed with alorithm.
    self.product1ImageView.image = nil;
    self.product2ImageView.image = nil;
    
    [self getProductCategory:1];
}

-(NSDictionary *)getProductCategory:(int)c
{
    static NSDictionary *returnDictionary = nil;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://burst.co.in/preview/GetProduct.php?cat=%d", c]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data.length > 0 && connectionError == nil) {
            NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            returnDictionary = greeting;
        }
    }];
    return returnDictionary;
}

-(void)initProduct1{
    static NSDictionary *returnDictionary = nil;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://burst.co.in/preview/GetProduct.php?cat=1"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data.length > 0 && connectionError == nil) {
            NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            returnDictionary = greeting;
            NSLog(@"Product 1: %@", returnDictionary);
        }
    }];
    
    
    self.product2ImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:returnDictionary[@"image_full_size"]]]];
}

-(void)initProduct2{
    static NSDictionary *returnDictionary = nil;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://burst.co.in/preview/GetProduct.php?cat=1"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data.length > 0 && connectionError == nil) {
            NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            returnDictionary = greeting;
            NSLog(@"Product 2: %@", returnDictionary);
        }
    }];
    
    self.product2ImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:returnDictionary[@"image_full_size"]]]];

}
- (IBAction)playGame:(id)sender {
    [self initProduct1];
    [self initProduct2];
}

@end
