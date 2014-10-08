//
//  PRShowJustReviewsViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 08/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRShowJustReviewsViewController.h"

@interface PRShowJustReviewsViewController ()

@end

@implementation PRShowJustReviewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentUser = [PFUser currentUser];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    PFQuery *queryForLikes = [PFQuery queryWithClassName:@"liked_products"];
    [queryForLikes whereKey:@"product_id" equalTo:self.productUniqueID];
    [queryForLikes countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"Error in getting the likes");
            
        }
        else{
            self.numberOfLikesLabel.text = [NSString stringWithFormat:@"%d",number];
        }
    }];
    PFQuery *queryForReviews = [PFQuery queryWithClassName:@"comments"];
    [queryForReviews whereKey:@"product_id" equalTo:self.productUniqueID];
    [queryForReviews countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"Error in getting the reviews");
        }
        else {
            self.numberOfReviewsLabel.text = [NSString stringWithFormat:@"%d",number];
        }
    }];
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(downTheShit)];
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:downSwipe];
    
}
-(void)downTheShit{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
