//
//  PRDetailPictureViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 24/03/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRDetailPictureViewController : UIViewController

@property (nonatomic, strong) NSData *imageData;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;

@end
