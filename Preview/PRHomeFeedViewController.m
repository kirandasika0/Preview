//
//  PRHomeFeedViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 10/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRHomeFeedViewController.h"
#import "PRFeedPost.h"
#import "PRModalDetailFeedViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "PRRelatedPicturesViewController.h"
#import "PRShowJustReviewsViewController.h"

@interface PRHomeFeedViewController ()

@end

@implementation PRHomeFeedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSLog(@"Current User: %@", currentUser.username);
    }
    else {
        [self performSegueWithIdentifier:@"showLogin" sender:nil];
    }
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    //We are only loading the view once and now the user has to use the refresh control. to make his view refresh.
    
    [self refresh];
    //We will also refresh the view after every one minute.
   
    //[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(refresh) userInfo:nil repeats:YES];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    }


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.feedPosts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PRFeedPost *feedPost = [self.feedPosts objectAtIndex:indexPath.row];
    cell.textLabel.text = feedPost.title;
    if ([feedPost.category isEqualToString:@"1"]) {
        cell.detailTextLabel.text = @"Movie";
    }
    if ([feedPost.category isEqualToString:@"2"]) {
        cell.detailTextLabel.text = @"Holiday Destionations";
    }
    if ([feedPost.category isEqualToString:@"3"]) {
        cell.detailTextLabel.text = @"Video Games";
    }
    if ([feedPost.category isEqualToString:@"4"]) {
        cell.detailTextLabel.text = @"Music";
    }
    if ([feedPost.category isEqualToString:@"5"]) {
        cell.detailTextLabel.text = @"Gadgets";
    }
    if ([feedPost.category isEqualToString:@"6"]) {
        cell.detailTextLabel.text = @"Books";
    }
    if ([feedPost.category isEqualToString:@"7"]) {
        cell.detailTextLabel.text = @"Applications";
    }
    if ([feedPost.category isEqualToString:@"8"]) {
        cell.detailTextLabel.text = @"Event";
    }
    if ([feedPost.category isEqualToString:@"9"]) {
        cell.detailTextLabel.text = @"Sports";
    }
    if ([feedPost.thumbnail isKindOfClass:[NSString class]]) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            NSData *imageData = [NSData dataWithContentsOfURL:feedPost.thumbnailURL];
            if (imageData != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage *image = [UIImage imageWithData:imageData];
                    cell.imageView.image = image;
                });
            }
        });
    }
    else {
        //cell.imageView.image = [UIImage imageNamed:@"export"];
    }
    
    //Gesture reg code down below.
    //UISwipeGestureRecognizer
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(share)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.tableView addGestureRecognizer:rightSwipe];
    
    //Adding left swpipe for more pictures.
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(pictures:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.tableView addGestureRecognizer:leftSwipe];
    //Adding a long press gesture reg.
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction)];
    [longPress setMinimumPressDuration:2];
    [self.view addGestureRecognizer:longPress];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PRFeedPost *feedPost = [self.feedPosts objectAtIndex:indexPath.row];
    NSLog(@"%@",feedPost.title);
    if (feedPost.title != 0) {
        [self performSegueWithIdentifier:@"showDetailPostFeed" sender:self];
    }
    else {
        //We are gonna do nothing for now.
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row) {
        //The table view has loaded so now we can hide the avtivity indicator.
        
        [self.activityInd stopAnimating];
    }
}

- (IBAction)logout:(id)sender {
    //We should now log the user out.
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showLogin" sender:nil];
}

#pragma mark - Main Segue Methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showLogin"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
    if ([segue.identifier isEqualToString:@"showDetailPostFeed"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PRFeedPost *feedPost = [self.feedPosts objectAtIndex:indexPath.row];
        PRModalDetailFeedViewController *modalViewController = (PRModalDetailFeedViewController *)segue.destinationViewController;
        
        modalViewController.productName = feedPost.title;
        modalViewController.productCategory = feedPost.category;
        modalViewController.productDecp = feedPost.decp;
        modalViewController.productRating  = feedPost.rating;
        modalViewController.productUniqueID = feedPost.uniqueID;
        
        
        NSURL *url = [[NSURL alloc] initWithString:feedPost.originalImage];
        NSData *imageData = [NSData dataWithContentsOfURL: url];
        modalViewController.thumbImageData = imageData;
        //we have sent all the data to the modal view controller
        
        
    }
    //This segue code is for the related pictures.
    if ([segue.identifier isEqualToString:@"showShareView"]) {
        //We have to just pass in the "ID"
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PRFeedPost *feedPost = [self.feedPosts objectAtIndex:indexPath.row];
        
        PRRelatedPicturesViewController *pictureViewController = (PRRelatedPicturesViewController *)segue.destinationViewController;
        
        //Sending the unique id to the picture modalviewcontroller.
        pictureViewController.productUniqueID = self.IDForRelatedProductPictures;
        pictureViewController.productName = feedPost.title;
        
        NSLog(@"%@",pictureViewController.productUniqueID);
        
    }
    if ([segue.identifier isEqualToString:@"showReviews"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PRFeedPost *feedPost = [self.feedPosts objectAtIndex:indexPath.row];
        
        PRShowJustReviewsViewController *justReviewsController = (PRShowJustReviewsViewController *)segue.destinationViewController;
        justReviewsController.productUniqueID = feedPost.uniqueID;
    }
    
}

#pragma mark - Main Method

-(void)refresh {
    //We are doing this in order to make sure than w=only when a user is logged in the the feed loads up ..
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        [self.activityInd startAnimating];
        NSURLSession *session = [NSURLSession sharedSession];
        NSString *urlString = [[NSString alloc] initWithFormat:@"http://www.burst.co.in/preview/json_emitter_1.php"];
        NSURL *url = [[NSURL alloc] initWithString:urlString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            
            NSData *data = [[NSData alloc] initWithContentsOfURL:location];
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                               options:kNilOptions error:nil];
            
            NSArray *feedPostsArray = [responseDictionary objectForKey:@"posts"];
            self.feedPosts = [NSMutableArray array];
            
            for (NSDictionary *fdDictionary in feedPostsArray) {
                PRFeedPost *feedPost = [PRFeedPost blogPostWithTitle:[fdDictionary objectForKey:@"product_name"]];
                feedPost.category = [fdDictionary objectForKey:@"product_category"];
                NSString *imageCheckString = [fdDictionary objectForKey:@"product_thumbnail"];
                if ([imageCheckString length] != 27) {
                    feedPost.thumbnail = [fdDictionary objectForKey:@"product_thumbnail"];
                }
                else {
                    feedPost.thumbnail = [fdDictionary objectForKey:@"product_original"];
                }
                feedPost.decp = [fdDictionary objectForKey:@"product_decp"];
                feedPost.rating = [fdDictionary objectForKey:@"product_rating"];
                feedPost.uniqueID = [fdDictionary objectForKey:@"id"];
                feedPost.originalImage = [fdDictionary objectForKey:@"product_original"];
                
                //We have to add all the object to the feed posts mutable array.
                
                [self.feedPosts addObject:feedPost];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
        if ([self.refreshControl isRefreshing]) {
            [self.refreshControl endRefreshing];
        }
        [task resume];
    }

}

-(void)share {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    PRFeedPost *feedPost = [self.feedPosts objectAtIndex:indexPath.row];
    
    //NSLog(@"Swiped right.");
    //[self performSegueWithIdentifier:@"showShareView" sender:nil];
    //Checking if the facebook app is installed or not
    //Making a Instace type of NSURl in the class of FbLInkShareParams
    
    FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
    NSString *urlString = [NSString stringWithFormat:@"http://burst.co.in/preview/web/view_product.php?id=%@",feedPost.uniqueID];
    NSLog(@"%@",urlString);
    params.link = [NSURL URLWithString:urlString];
    
    if ([FBDialogs canPresentShareDialogWithParams:params]) {
        //We can show the fbDialog.
        [FBDialogs presentShareDialogWithLink:params.link handler:^(FBAppCall *call, NSDictionary *results, NSError *error){
            if (error) {
                //An error occured we can show it in the log
                NSLog(@"Error: %@",error.description);
            }
            else {
                NSLog(@"Results: %@", results);
            }
        }];
    }
    else {
        //We will just say in the alert view for the user to download the facbook app in order to share from preview..
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Whoa!" message:@"Please download the facbook app in order to share a product swith your friends." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    
}

-(void)pictures: (UISwipeGestureRecognizer *)gesutre{
    CGPoint location = [gesutre locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    //UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%ld",indexPath.row);
    PRFeedPost *feedPost = [self.feedPosts objectAtIndex:indexPath.row];
    self.IDForRelatedProductPictures = feedPost.uniqueID;
    if (self.IDForRelatedProductPictures) {
        [self performSegueWithIdentifier:@"showShareView" sender:self];
    }
}
-(void)longPressAction{
    //[self performSegueWithIdentifier:@"showReviews" sender:nil];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    PRFeedPost *feedPost = [self.feedPosts objectAtIndex:indexPath.row];
    PFQuery *queryForLikes = [PFQuery queryWithClassName:@"liked_products"];
    [queryForLikes whereKey:@"product_id" equalTo:feedPost.uniqueID];
    [queryForLikes countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"Error.");
        }
        else{
            self.likesString = [NSString stringWithFormat:@"%d",number];
        }
    }];
    PFQuery *queryForReviews = [PFQuery queryWithClassName:@"comments"];
    [queryForReviews whereKey:@"product_id" equalTo:feedPost.uniqueID];
    [queryForReviews countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"Error.");
        }
        else{
            self.reviewsString = [NSString stringWithFormat:@"%d",number];
        }
    }];
    
    NSString *quickInformationString = [NSString stringWithFormat:@"Likes: %@ \n Reviews: %@",self.likesString,self.reviewsString];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Quick Info" message:quickInformationString delegate: nil cancelButtonTitle:nil otherButtonTitles: nil];
    [alertView reloadInputViews];
    [alertView show];
    
    [self performSelector:@selector(closeQuickAlert:) withObject:alertView afterDelay:3];
}

-(void)closeQuickAlert:(UIAlertView *)x{
    [x dismissWithClickedButtonIndex:-1 animated:YES];
}

@end
