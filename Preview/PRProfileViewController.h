//
//  PRProfileViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 08/06/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface PRProfileViewController : UIViewController
//USername label and IB outlet must be created in order to display the username
@property (weak, nonatomic) IBOutlet UILabel *userFullNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIWebView *displaySeenProductsWebView;

@end
