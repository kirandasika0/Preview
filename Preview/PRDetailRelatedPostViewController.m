//
//  PRDetailRelatedPostViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 23/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRDetailRelatedPostViewController.h"

@interface PRDetailRelatedPostViewController ()

@end

@implementation PRDetailRelatedPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.scrollView layoutIfNeeded];
    self.scrollView.contentSize = self.contentView.bounds.size;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view reloadInputViews];
    self.productNameLabel.text = self.productName;
    self.productDecpLabel.text = self.productDecp;
    self.productDecpLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.productDecpLabel.numberOfLines = 0;
    NSURL *imageURL = [NSURL URLWithString:self.imageURLString];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    self.productImageView.image = image;
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeView)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
}

-(void)closeView{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
