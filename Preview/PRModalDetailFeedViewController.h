//
//  PRModalDetailFeedViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 11/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>

@class PRColorWheel;
@interface PRModalDetailFeedViewController : UIViewController<CLLocationManagerDelegate>
{
        CLLocationManager *locationManager;
}

@property (nonatomic,strong) NSString *productName;
@property (nonatomic,strong) NSString *productCategory;
@property (nonatomic,strong) NSString *productDecp;
@property (nonatomic,strong) NSData *thumbImageData;
@property (nonatomic,strong) NSString *productRating;
@property (nonatomic,strong) NSString *productUniqueID;
@property (nonatomic, strong) PRColorWheel *colorWheel;

#pragma mark - Parse Objects
@property (nonatomic,strong) PFUser *currentUser;



#pragma mark - All IB Outlets
@property (weak, nonatomic) IBOutlet UIImageView *feedImageView;
@property (weak, nonatomic) IBOutlet UILabel *productnameLabel;

@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UITextView *productDecpTextView;
@property (weak, nonatomic) IBOutlet UILabel *ratinglabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfLikesLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfReviewsLabel;
@property (weak, nonatomic) IBOutlet UIButton *longTapShareButton;

- (IBAction)homeTabAction:(id)sender;

//Loading Physics views

@property (weak, nonatomic) IBOutlet UIView *yellowSqaure;
@property (weak, nonatomic) IBOutlet UIView *blueSquare;

//Share button IBOutlet
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UIButton *showRelatedPics;
- (IBAction)showRelatedPics:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *linkCopy;
- (IBAction)linkCopy:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *markAsFavButton;
- (IBAction)markAsFavButton:(id)sender;

@end
