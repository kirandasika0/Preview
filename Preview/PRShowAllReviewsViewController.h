//
//  PRShowAllReviewsViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 04/11/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PRShowAllReviewsViewController : UITableViewController

@property (strong, nonatomic) NSArray *allReviews;
@property (strong, nonatomic) NSString *userOBJID;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic, strong) PFUser *currentUser;
- (IBAction)likeReviews:(id)sender;


@end
