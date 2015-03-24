//
//  PRDetailPictureViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 24/03/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import "PRDetailPictureViewController.h"

@interface PRDetailPictureViewController ()

@end

@implementation PRDetailPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImage *image = [UIImage imageWithData:self.imageData];
    self.pictureImageView.image = image;
}

- (IBAction)closeDetailPicture:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
