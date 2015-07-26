//
//  PRProfileViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 08/06/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRProfileViewController.h"
#import "SAMCache.h"
#import "PRRelatedViewController.h"
#import "NSDate+NVTimeAgo.h"

@interface PRProfileViewController ()

@end

@implementation PRProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.currentUser = [PFUser currentUser];
    self.tableView.alpha = 0.0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.profilePictureImageView.layer.cornerRadius = 50.0;
    
    //getting the profile picture only for once.
    PFQuery *profilePictureQuery = [PFUser query];
    [profilePictureQuery getObjectInBackgroundWithId:self.currentUser.objectId block:^(PFObject *object, NSError *error) {
        if (!error) {
            PFFile *profilePictureFile = object[@"pro_pic"];
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            
            dispatch_async(queue, ^{
                NSData *profileImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:profilePictureFile.url]];
                if(profileImageData != nil){
                    //setting up another grand dispatch for setting the ui image
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImage *profileImage = [UIImage imageWithData:profileImageData]; //we have the uiimage object
                        //setting the uiimage above to the image view
                        self.profilePictureImageView.image = profileImage;
                    });
                }
            });
            
            //getting cover image too
            
            PFFile *coverPictureFile = object[@"cover_pic"];
            dispatch_async(queue, ^{
                NSData *coverImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:coverPictureFile.url]];
                if (coverImageData != nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImage *coverImage = [UIImage imageWithData:coverImageData];
                        self.coverImageView.image = coverImage;
                    });
                }
            });
            
        }
    }];
    
    

    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getUserReviews];
    self.tabBarController.tabBar.hidden = NO;
    //Setting the tab bar controller
    //Setting up the profile page.
    PFUser *currentUser = [PFUser currentUser];
    //Setting the user full name on  the usernamelabel
    self.userFullNameLabel.text = [NSString stringWithFormat:@"%@ | %@",currentUser[@"fullName"],currentUser.username];
    self.userFullNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.userFullNameLabel.numberOfLines = 0;
    //load the profile picture

    
    //adding long press gesture for deleting a review
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPressGesture.minimumPressDuration = 2.0;
    longPressGesture.delegate = self;
    [self.tableView addGestureRecognizer:longPressGesture];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //adding animation here for better ui
    [UIView animateWithDuration:4.0 animations:^{
        self.tableView.alpha = 1.0;
    } completion:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.userReviews count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *review = [self.userReviews objectAtIndex:indexPath.row];
    NSDate *commentedDate = [review objectForKey:@"sentOn"];
    NSString *mainString = [NSString stringWithFormat:@"%@ | %@", [review objectForKey:@"username"], [commentedDate formattedAsTimeAgo]];
    cell.textLabel.text = mainString;
    cell.detailTextLabel.text = [review objectForKey:@"comment"];
    return cell;
}


-(void)getUserReviews{
    PFQuery *query = [PFQuery queryWithClassName:@"comments"];
    [query whereKey:@"user_id" equalTo:self.currentUser.objectId];
    [query orderByDescending:@"createdAt"];
    //query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.userReviews = objects;
            //if there are no reviews then hide the table view
            if(self.userReviews.count != 0){
            [self.tableView reloadData];
            }
            else{
                //hide the table view if the there are no users.
                [self.tableView setHidden:YES];
            }
        }
    }];
}

#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showEditProfile"]) {
        [self.tabBarController setHidesBottomBarWhenPushed:YES];
    }
    
    if ([segue.identifier isEqualToString:@"showSettings"]) {
        [self.tabBarController setHidesBottomBarWhenPushed:YES];
    }
}

- (IBAction)openRelatedSearches:(id)sender {
//    PRRelatedViewController *viewController = [[PRRelatedViewController alloc] init];
//    [self presentViewController:viewController animated:YES completion:nil];
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
    if (indexPath == nil) {
        //NSLog(@"long press on table view but not on a row");
    } else if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"long press on table view at row %ld", (long)indexPath.row);
        
        //we have to ask the user to delete his selected review
        
        UIAlertView *deleteReviewAlertView = [[UIAlertView alloc] initWithTitle:@"Are you sure?" message:@"Do you want to delete this review?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
        [deleteReviewAlertView show];
        self.toBeDeletedIndexPath = indexPath;
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        [cell setHidden:YES];
        
    } else {
        //NSLog(@"gestureRecognizer.state = %ld", (long)gestureRecognizer.state);
    }
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //NSLog(@"%ld", (long)buttonIndex);
    
    //Checks For Approval
    if (buttonIndex == 1) {
        //do something because they selected button one, yes
        //this object has to be deleted now
        PFObject *reviewObject = [self.userReviews objectAtIndex:self.toBeDeletedIndexPath.row];
        [reviewObject deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                //we can now reload the data in the table view
                [self getUserReviews];
            }
            else{
                NSLog(@"Error: %@", [error.userInfo objectForKeyedSubscript:@"error"]);
            }
        }];
        
    } else {
        //do nothing because they selected no
    }
}
@end
