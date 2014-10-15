//
//  PRPurchaseWebViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 16/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PRPurchaseWebViewController : UIViewController

@property (strong, nonatomic) PFUser *currentUser;
@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end
