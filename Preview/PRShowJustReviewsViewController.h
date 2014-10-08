//
//  PRShowJustReviewsViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 08/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PRShowJustReviewsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *numberOfLikesLabel;

@property (weak, nonatomic) IBOutlet UILabel *numberOfReviewsLabel;


@property (strong, nonatomic) PFUser *currentUser;
@property (strong, nonatomic) NSString *productUniqueID;

@end
