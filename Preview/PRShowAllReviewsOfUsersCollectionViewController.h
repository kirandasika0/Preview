//
//  PRShowAllReviewsOfUsersCollectionViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 23/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PRShowAllReviewsOfUsersCollectionViewController : UICollectionViewController

@property (nonatomic, strong) NSString *userOBJID;
@property (nonatomic, strong) NSArray *allReviews;

@end
