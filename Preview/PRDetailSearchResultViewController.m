//
//  PRDetailSearchResultViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 01/08/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import "PRDetailSearchResultViewController.h"
#import "UIImageEffects.h"
#import "SAMCache.h"

@interface PRDetailSearchResultViewController ()

@end

@implementation PRDetailSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.scrollView setScrollEnabled:YES];
    self.navigationItem.title = self.product[@"product_name"];
    NSString *productNameLabelString = [NSString stringWithFormat:@"Product Name: %@\n\nProduct Rating: %@", self.product[@"product_name"], self.product[@"product_rating"]];
    self.productNameLabel.text = productNameLabelString;
    self.productDescrptionTextView.text = self.product[@"product_description"];
    NSString *key = [NSString stringWithFormat:@"%@-thumbnail", self.product[@"id"]];
    self.productBackgroundImageView.image = [UIImageEffects imageByApplyingBlurToImage:[[SAMCache sharedCache] imageForKey:key] withRadius:12.0 tintColor:[UIColor colorWithWhite:1.0 alpha:0.42] saturationDeltaFactor:1.2 maskImage:nil];
}

-(void)revealBackroundImage{
    [UIView animateWithDuration:1.5 animations:^{
        self.productNameLabel.alpha = 0.0;
        self.productDescrptionTextView.alpha = 0.0;
        
        //setting the image for the button here as category
        [self.revealBackgroundImageButton setImage:[UIImage imageNamed:@"category"] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        [self.productBackgroundImageView setContentMode:UIViewContentModeScaleAspectFit];
        self.productBackgroundImageView.image = [[SAMCache sharedCache] imageForKey:[NSString stringWithFormat:@"%@-thumbnail", self.product[@"id"]]];
    }];
}

- (IBAction)revealImage:(id)sender {
    
    if (self.productNameLabel.alpha == 0.0) {
        [UIView animateWithDuration:1.5 animations:^{
            self.productNameLabel.alpha = 1.0;
            self.productDescrptionTextView.alpha = 1.0;
            self.productBackgroundImageView.alpha = 0.0;
            
            //setting the image here as the image icon for view the background image again
            [self.revealBackgroundImageButton setImage:[UIImage imageNamed:@"picture"] forState:UIControlStateNormal];
        } completion:^(BOOL finished) {
            [self.productBackgroundImageView setContentMode:UIViewContentModeScaleToFill];
            self.productBackgroundImageView.alpha = 1.0;
            NSString *key = [NSString stringWithFormat:@"%@-thumbnail", self.product[@"id"]];
            self.productBackgroundImageView.image = [UIImageEffects imageByApplyingBlurToImage:[[SAMCache sharedCache] imageForKey:key] withRadius:12.0 tintColor:[UIColor colorWithWhite:1.0 alpha:0.42] saturationDeltaFactor:1.2 maskImage:nil];
        }];
    }
    else{
        //we are gonna reveal the background image slowly with a UIView Animation
        [self revealBackroundImage];
    }

    
}
@end
