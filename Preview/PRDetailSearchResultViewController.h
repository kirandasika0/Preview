//
//  PRDetailSearchResultViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 01/08/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRDetailSearchResultViewController : UIViewController
@property (strong, nonatomic) NSDictionary *product;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *productDescrptionTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)revealImage:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *productBackgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *revealBackgroundImageButton;
@property (strong, nonatomic) UIImage *originalImage;

- (IBAction)showGallery:(id)sender;

@end
