//
//  PRModalDetailFeedViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 11/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRModalDetailFeedViewController : UIViewController

@property (nonatomic,strong) NSString *productName;
@property (nonatomic,strong) NSString *productCategory;
@property (nonatomic,strong) NSString *productDecp;
@property (nonatomic,strong) NSData *thumbImageData;
@property (nonatomic,strong) NSString *productRating;
@property (nonatomic,strong) NSString *productUniqueID;



#pragma mark - All IB Outlets
@property (weak, nonatomic) IBOutlet UIImageView *feedImageView;
@property (weak, nonatomic) IBOutlet UILabel *productnameLabel;

@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UITextView *productDecpTextView;
@property (weak, nonatomic) IBOutlet UILabel *ratinglabel;

- (IBAction)homeTabAction:(id)sender;


@end
