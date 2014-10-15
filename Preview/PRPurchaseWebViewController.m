//
//  PRPurchaseWebViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 16/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRPurchaseWebViewController.h"

@interface PRPurchaseWebViewController ()

@end

@implementation PRPurchaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentUser = [PFUser currentUser];
    NSString *urlString = [NSString stringWithFormat:@"http://burst.co.in/preview/web/index.php?id=%@",[self.currentUser objectId]];
    NSURL *urlFromString = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlFromString];
    [self.webView loadRequest:request];
}

@end
