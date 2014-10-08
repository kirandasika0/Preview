//
//  PRHomeFeedViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 10/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PRHomeFeedViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray *feedPosts;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityInd;
- (IBAction)shoeSettingsPopover:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *showReviewButton;


@property (strong,nonatomic) NSTimer *timer;
@property (strong,nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) UIPopoverController *popOver;

- (IBAction)logout:(id)sender;

@property (nonatomic,strong) NSString *IDForRelatedProductPictures;

@end
