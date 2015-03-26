//
//  PRShowOriginalPictureViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 25/03/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import "PRShowOriginalPictureViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SAMCache.h"

@interface PRShowOriginalPictureViewController ()

@end

@implementation PRShowOriginalPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
    tap.numberOfTapsRequired = 2;
    [self.originalImageImageView addGestureRecognizer:tap];
    
    //Making close button circle
    self.closeButton.layer.cornerRadius = CGRectGetWidth(self.closeButton.frame) / 2.0;
    [self.activityIndicator startAnimating];
     //Setting the view
    self.productNameLabel.text = self.productName;
    NSURL *imageURL = [NSURL URLWithString:self.orignalImageString];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        if (imageData != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *image = [UIImage imageWithData:imageData];
                
                self.originalImageImageView.image = image;
                [self.activityIndicator stopAnimating];

            });
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)dismissView{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
