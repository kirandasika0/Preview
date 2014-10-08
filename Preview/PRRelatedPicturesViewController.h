//
//  PRRelatedPicturesViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 05/06/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRRelatedPicturesViewController : UICollectionViewController

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityInd;
@property (strong,nonatomic) NSString *productUniqueID;
@property (nonatomic,strong) NSMutableArray *allPics;
@property (nonatomic,strong) NSString *productName;

@property(nonatomic,strong) NSString *imageOriginal;
@property(strong,nonatomic) NSString *imageThumbnail;

#pragma mark - IB Outlets
@property (weak, nonatomic) IBOutlet UIImageView *image;


@end
