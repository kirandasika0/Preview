//
//  PRModalDetailFeedViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 11/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRModalDetailFeedViewController.h"
#import "PRInsertCommentViewController.h"
#import "PRcommentsCollectionViewController.h"

@interface PRModalDetailFeedViewController ()

@end

@implementation PRModalDetailFeedViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    //the blow fnction is for getting the numbe of comments and the number of likes.
    [self getMainContent];
    //We are setting the currentUser property to the current user..
    self.currentUser = [PFUser currentUser];
    
    //Setting the product label name in the below line.
    
    self.productnameLabel.text = self.productName;
    
    //We have set the category of the product in the below if and else block. :D
    if ([self.productCategory isEqualToString:@"1"]) {
        self.category.text = @"Category: Movies";
    }
    if ([self.productCategory isEqualToString:@"2"]) {
        self.category.text = @"Category: Holiday Destinations";
    }
    if ([self.productCategory isEqualToString:@"3"]) {
        self.category.text = @"Category: Video Games";
    }
    if ([self.productCategory isEqualToString:@"4"]) {
        self.category.text = @"Category: Music";
    }
    if ([self.productCategory isEqualToString:@"5"]) {
        self.category.text = @"Category: Gadgets";
    }
    
    if ([self.productCategory isEqualToString:@"6"]) {
        self.category.text = @"Category: Books";
    }
    if ([self.productCategory isEqualToString:@"7"]) {
        self.category.text = @"Category: Applications";
    }
    if ([self.productCategory isEqualToString:@"8"]) {
        self.category.text = @"Category: Events";
    }
    if ([self.productCategory isEqualToString:@"9"]) {
        self.category.text = @"Category: Sports";
    }
    UIImage *displayImage = [UIImage imageWithData:self.thumbImageData];
    
    self.feedImageView.image = displayImage;
    
    //We have to show the discription.
    
    NSString *fullDecp = [NSString stringWithFormat:@"Product Description: \n %@",self.productDecp];
    self.productDecpTextView.text = fullDecp;
    
    //We have to set the rating label too...
    NSString *fullRatingString = [NSString stringWithFormat:@"Preview Rating: %@ / 10",self.productRating];
    self.ratinglabel.text = fullRatingString;
    
    // ==============================================================================
    
    //Double tap to dismiss the modal view controller
    //using a gesture reg.
    UITapGestureRecognizer *tapToCancel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel)];
    tapToCancel.numberOfTapsRequired = 2;
    
    [self.view addGestureRecognizer:tapToCancel];
    
    //Adding the swipe gesture regognozer for sharing\
    //Added the gesture reg in the home feed view controller for better UI exp.
    
    //adding the pan geesture to make a like to the product.
    UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(likeProduct)];
    upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:upSwipe];
    //down swipe
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(unlikeProduct)];
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:downSwipe];
    //UI swipe gesture for right swipe
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(movetoComment)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
    //left swipe for inserting comment
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(movetoInsertComment)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipe];
    
}

-(void)likeProduct{
    PFQuery *queryForLike = [PFQuery queryWithClassName:@"liked_products"];
    [queryForLike whereKey:@"product_id" equalTo:self.productUniqueID];
    [queryForLike whereKey:@"user_id" equalTo:self.currentUser.objectId];
    [queryForLike countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (number == 0) {
            PFObject *likeForCurrentProduct = [[PFObject alloc] initWithClassName:@"liked_products"];
            likeForCurrentProduct[@"product_id"] = self.productUniqueID;
            likeForCurrentProduct[@"user_id"] = self.currentUser.objectId;
            likeForCurrentProduct[@"username"] = self.currentUser.username;
            [likeForCurrentProduct saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    NSLog(@"Error.");
                }
                else {
                    //display alertview
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Liked :)" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
                    [alertView show];
                    [alertView dismissWithClickedButtonIndex:0 animated:YES];
                }
            }];
        }
        else {
            UIAlertView *alreadyLikedAlerView = [[UIAlertView alloc] initWithTitle:@"Liked already." message:@"If you want to unlike the product, Swipe down to unlike this." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alreadyLikedAlerView show];
        }
    }];
}

-(void)unlikeProduct{
    PFQuery *deleteCurrentLike = [PFQuery queryWithClassName:@"liked_products"];
    [deleteCurrentLike whereKey:@"product_id" equalTo:self.productUniqueID];
    [deleteCurrentLike whereKey:@"user_id" equalTo:self.currentUser.objectId];
    [deleteCurrentLike countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (number > 0) {
            [deleteCurrentLike findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                for (PFObject *object in objects) {
                    [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        UIAlertView *deleteAlertView = [[UIAlertView alloc] initWithTitle:@"Unliked :(" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
                        [deleteAlertView show];
                        [deleteAlertView dismissWithClickedButtonIndex:0 animated:YES];
                    }];
                }
            }];
        }
        else {
            //uialert view
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Whoa!" message:@"Looks like you are trying to dislike a product even before liking it." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [errorAlertView show];
        }
    }];
}

-(void)movetoComment{
    [self performSegueWithIdentifier:@"showComments" sender:self];
}

-(void)movetoInsertComment {
    [self performSegueWithIdentifier:@"showInsertComment" sender:self];
}

- (IBAction)homeTabAction:(id)sender {
    //We will only direct the user in to the previous vewi controller
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showInsertComment"]) {
        PRInsertCommentViewController *modalViewController = (PRInsertCommentViewController *)segue.destinationViewController;
        modalViewController.productUniqueID = self.productUniqueID;
    }
    if ([segue.identifier isEqualToString:@"showComments"]) {
        PRcommentsCollectionViewController *modalViewForCommentsViewing = (PRcommentsCollectionViewController *)segue.destinationViewController;
        modalViewForCommentsViewing.productUniqueID = self.productUniqueID;
    }
}
-(void)getMainContent{
    PFQuery *queryForLikes = [PFQuery queryWithClassName:@"liked_products"];
    [queryForLikes whereKey:@"product_id" equalTo:self.productUniqueID];
    [queryForLikes countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"Error.");
            
        }
        else{
            self.numberOfLikesLabel.text = [NSString stringWithFormat:@"%d Likes",number];
        }
    }];
    PFQuery *queryForComments = [PFQuery queryWithClassName:@"comments"];
    [queryForComments whereKey:@"product_id" equalTo:self.productUniqueID];
    [queryForComments countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"Error Comments.");
        
        }
        else{
            self.numberOfReviewsLabel.text = [NSString stringWithFormat:@"%d Reviews",number];
        }
    }];
}
-(void)cancel {
    PFObject *currentProduct = [PFObject objectWithClassName:@"seenProducts"];
    currentProduct[@"product_id"] = self.productUniqueID;
    currentProduct[@"product_name"] = self.productName;
    currentProduct[@"product_category"] = self.productCategory;
    currentProduct[@"product_rating"] = self.productRating;
    currentProduct[@"username"] = self.currentUser.username;
    currentProduct[@"userID"] = self.currentUser.objectId;
    
    [currentProduct saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"Error!");
        }
    }];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
