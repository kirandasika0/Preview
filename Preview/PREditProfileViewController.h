//
//  PREditProfileViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 14/06/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PREditProfileViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)setAsDPButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *setAsCoverImageButton;
- (IBAction)setAsCoverImageButton:(id)sender;


@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) CIImage *CIImage;
@end
