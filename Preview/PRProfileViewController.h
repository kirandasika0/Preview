//
//  PRProfileViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 08/06/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>

@interface PRProfileViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
//USername label and IB outlet must be created in order to display the username
@property (weak, nonatomic) IBOutlet UILabel *userFullNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIWebView *displaySeenProductsWebView;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) PFUser *currentUser;
@property (nonatomic,strong) NSArray *userReviews;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *openRelatedSearches;
@property (weak, nonatomic) NSIndexPath *toBeDeletedIndexPath;
- (IBAction)openRelatedSearches:(id)sender;


@end
