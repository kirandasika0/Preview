//
//  PRSearchCell.m
//  Preview
//
//  Created by SaiKiran Dasika on 01/08/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import "PRSearchCell.h"
#import "UIImageEffects.h"
#import "PRColorWheel.h"
#import "SAMCache.h"

@implementation PRSearchCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCellForProduct:(NSDictionary *)product{
    PRColorWheel *colorWheel = [[PRColorWheel alloc] init];
    //setting a random text color
    NSString *key = [NSString stringWithFormat:@"%@-thumbnail", product[@"id"]];
    self.productNameLabel.textColor = [UIColor blackColor];
    self.productNameLabel.text = product[@"product_name"];
    if ([[SAMCache sharedCache] imageExistsForKey:key] == TRUE ) {
        self.productImageView.image = [UIImageEffects imageByApplyingBlurToImage:[[SAMCache sharedCache] imageForKey:key] withRadius:11.5 tintColor:[UIColor colorWithWhite:1 alpha:0.42] saturationDeltaFactor:1.2 maskImage:nil];
    }
    else{
    NSURL *imageURL = [NSURL URLWithString:product[@"product_original"]];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        if (imageData != nil) {
            //getting back to the main queue
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *productImage = [UIImage imageWithData:imageData];
                UIImage *effectedProductImage = [UIImageEffects imageByApplyingBlurToImage:productImage withRadius:11.5 tintColor:[UIColor colorWithWhite:1 alpha:0.42] saturationDeltaFactor:1.2 maskImage:nil];
                self.productImageView.image = effectedProductImage;

            });
        }
    });
    }
}

@end
