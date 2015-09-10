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
#import "AFNetworking.h"
#import "PRProductGalleryViewController.h"


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
    NSString *productNameLabelString = [NSString stringWithFormat:@"Product Name: %@\n\nProduct Rating: %@/10", self.product[@"product_name"], self.product[@"product_rating"]];
    self.productNameLabel.text = productNameLabelString;
    self.productDescrptionTextView.text = self.product[@"product_description"];
    NSString *key = [NSString stringWithFormat:@"%@-thumbnail", self.product[@"id"]];
    if ([[SAMCache sharedCache] imageExistsForKey:key]) {
        self.productBackgroundImageView.image = [UIImageEffects imageByApplyingBlurToImage:[[SAMCache sharedCache] imageForKey:key] withRadius:12.0 tintColor:[UIColor colorWithWhite:1.0 alpha:0.42] saturationDeltaFactor:1.2 maskImage:nil];
    }
    else{
        //The thumbnail image does not exsist
        //we have to download the original image and then put it in tht background
        NSURL *backgroundImageURL = [NSURL URLWithString:self.product[@"product_original"]];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            NSData *backgroundImageData = [NSData dataWithContentsOfURL:backgroundImageURL];
            if (backgroundImageData != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.productBackgroundImageView.image = [UIImageEffects imageByApplyingBlurToImage:[UIImage imageWithData:backgroundImageData] withRadius:12.0 tintColor:[UIColor colorWithWhite:1.0 alpha:0.42] saturationDeltaFactor:1.2 maskImage:nil];
                    //setting a property of original image
                    self.originalImage = [UIImage imageWithData:backgroundImageData];
                });
            }
        });
    }
}

-(void)revealBackroundImage{
    [UIView animateWithDuration:1.5 animations:^{
        self.productNameLabel.alpha = 0.0;
        self.productDescrptionTextView.alpha = 0.0;
        
        //setting the image for the button here as category
        [self.revealBackgroundImageButton setImage:[UIImage imageNamed:@"category"] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        [self.productBackgroundImageView setContentMode:UIViewContentModeScaleAspectFit];
        //if the thumbnail picture is there then we are gonna display the thumbnail
        if ([[SAMCache sharedCache] imageExistsForKey:[NSString stringWithFormat:@"%@-thumbnail", self.product[@"id"]]]) {
            //displaying the thumbnail picture
            self.productBackgroundImageView.image = [[SAMCache sharedCache] imageForKey:[NSString stringWithFormat:@"%@-thumbnail", self.product[@"id"]]];
        }
        else{
            //we have to display the big picture
            if (self.originalImage != nil) {
                //display the picture
                self.productBackgroundImageView.image = self.originalImage;
            }
        }
    }];
    
    //let's send a test connection to server for related pictures
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters  = @{@"id": self.product[@"id"]};
    NSLog(@"%@", parameters);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [manager POST:@"https://preview-backend.herokuapp.com/backend/get_related_pics/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Looks like there was a problem in the network connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        NSLog(@"%@", error);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
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
            if ([[SAMCache sharedCache] imageExistsForKey:key]) {
                self.productBackgroundImageView.image = [UIImageEffects imageByApplyingBlurToImage:[[SAMCache sharedCache] imageForKey:key] withRadius:12.0 tintColor:[UIColor colorWithWhite:1.0 alpha:0.42] saturationDeltaFactor:1.2 maskImage:nil];
            }
            else{
                if (self.originalImage != nil) {
                    self.productBackgroundImageView.image = [UIImageEffects imageByApplyingBlurToImage:self.originalImage withRadius:12.0 tintColor:[UIColor colorWithWhite:1.0 alpha:0.42] saturationDeltaFactor:1.2 maskImage:nil];
                }
            }
        }];
    }
    else{
        //we are gonna reveal the background image slowly with a UIView Animation
        [self revealBackroundImage];
        //after revealing the backgound image we have to also hide it when the user clicks the information button
    }

    
}

- (IBAction)showGallery:(id)sender {
    //Display the modal view controller
    [self performSegueWithIdentifier:@"showGallery" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showGallery"]) {
        PRProductGalleryViewController *viewController = (PRProductGalleryViewController *)segue.destinationViewController;
        viewController.productId = self.product[@"id"];
    }
}
@end
