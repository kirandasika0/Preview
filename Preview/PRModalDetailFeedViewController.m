//
//  PRModalDetailFeedViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 11/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRModalDetailFeedViewController.h"
#import <Parse/Parse.h>

@interface PRModalDetailFeedViewController ()

@end

@implementation PRModalDetailFeedViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.productnameLabel.text = self.productName;
    //We have set the category of the product in the below if and else block. :D
    if ([self.productCategory isEqualToString:@"1"]) {
        self.category.text = @"Movies";
    }
    if ([self.productCategory isEqualToString:@"2"]) {
        self.category.text = @"Lifestyle";
    }
    if ([self.productCategory isEqualToString:@"3"]) {
        self.category.text = @"Video Games";
    }
    if ([self.productCategory isEqualToString:@"4"]) {
        self.category.text = @"Music";
    }
    if ([self.productCategory isEqualToString:@"5"]) {
        self.category.text = @"Gadgets";
    }
    
    if ([self.productCategory isEqualToString:@"6"]) {
        self.category.text = @"Books";
    }
    
    UIImage *displayImage = [UIImage imageWithData:self.thumbImageData];
    
    self.feedImageView.image = displayImage;
    
    //We have to show the discription.
    
    NSString *fullDecp = [NSString stringWithFormat:@"Product Description: \n %@",self.productDecp];
    self.productDecpTextView.text = fullDecp;
    
    //We have to set the rating label too...
    NSString *fullRatingString = [NSString stringWithFormat:@"Preview Rating: %@ / 10",self.productRating];
    self.ratinglabel.text = fullRatingString;
    
    // ==============================================================================
    
    
}


- (IBAction)homeTabAction:(id)sender {
    //We will only direct the user in to the previous vewi controller
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
