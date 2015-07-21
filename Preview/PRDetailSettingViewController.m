//
//  PRDetailSettingViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 21/07/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import "PRDetailSettingViewController.h"

@interface PRDetailSettingViewController ()

@end

@implementation PRDetailSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    NSURLRequest *reqeust = [NSURLRequest requestWithURL:self.detailSettingURL];
    [self.settingWebView loadRequest:reqeust];
}

@end
