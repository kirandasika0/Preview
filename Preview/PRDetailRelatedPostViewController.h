//
//  PRDetailRelatedPostViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 23/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRDetailRelatedPostViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;

@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *productDecpLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;


@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productDecp;
@property (nonatomic, strong) NSString *imageURLString;

@end
