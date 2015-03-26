//
//  PRShowOriginalPictureViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 25/03/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRShowOriginalPictureViewController : UIViewController
@property (nonatomic, strong) NSString *productName;
@property (nonatomic,strong) NSString *orignalImageString;


@property (weak, nonatomic) IBOutlet UIImageView *originalImageImageView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
- (IBAction)closeButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
