//
//  PRRateGameViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 27/04/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import "PRRateGameViewController.h"
#import "PRColorWheel.h"

@interface PRRateGameViewController ()

@end

@implementation PRRateGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Change the background of the view
    self.colorWheel = [[PRColorWheel alloc] init];
    self.vView.backgroundColor = [self.colorWheel randomColor];
    
    //Make the vs view round
    self.vView.clipsToBounds = YES;
    self.vView.layer.cornerRadius = CGRectGetWidth(self.vView.frame) / 2.0f;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden = NO;
}



@end
