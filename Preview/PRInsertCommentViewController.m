//
//  PRInsertCommentViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 04/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRInsertCommentViewController.h"
#import "PRUserLocation.h"
#import "MSCellAccessory.h"

@interface PRInsertCommentViewController ()

@end

@implementation PRInsertCommentViewController
@synthesize ratingTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentUser = [PFUser currentUser];
    //loading the number of stars that have to be
    self.ratingParas = [[NSArray alloc] initWithObjects:@"1 Star", @"2 Star", @"3 Stars", @"4 Stars", @"5 Stars", nil];
    self.ratingTableView.delegate = self;
    self.ratingTableView.dataSource = self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //setting the alpha of the stars table view to zero to animate it in view did apper
    self.ratingTableView.alpha = 0.0;
    self.commentTextView.alpha = 0.0;
    
    UITapGestureRecognizer *closeInsertPost = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeViewController)];
    closeInsertPost.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:closeInsertPost];
    //[self.ratingTableView reloadData];
    //[self getUserDetails];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:1.5 animations:^{
        if (self.ratingTableView.alpha == 0.0 && self.commentTextView.alpha == 0.0) {
            self.commentTextView.alpha = 1.0;
            self.ratingTableView.alpha = 1.0;
        }
    } completion:nil];
}

- (IBAction)insertComment:(id)sender {
    NSString *comment = [self.commentTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([comment length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Looks like you haven't typed anything in the comment text box." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else {
        if (self.selectedStar != 0) {
            PFObject *currentComment = [PFObject objectWithClassName:@"comments"];
            currentComment[@"product_id"] = self.productUniqueID;
            currentComment[@"user_id"] = self.currentUser.objectId;
            currentComment[@"username"] = self.currentUser.username;
            currentComment[@"fullName"] = [self.currentUser objectForKey:@"fullName"];
            currentComment[@"comment"] = comment;
            NSDate *todaysDate = [[NSDate alloc] init];
            currentComment[@"sentOn"] = todaysDate;
            [currentComment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    //there wsas an error in getting information from parse
                    NSLog(@"Error.");
                }
                else {
                    //[self dismissViewControllerAnimated:YES completion:nil];
                    NSLog(@"Uploaded.");
                    [self sendStarRatingWithProductId:self.productUniqueID andCommentId:currentComment.objectId];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }];
        }
        else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Whoops..." message:@"Please select a star to submit" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
        }
    }
}
-(void)closeViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table View Methods Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.ratingParas count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.ratingTableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    //We have to popoulate the table view
    cell.textLabel.text = self.ratingParas[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //we have to store the table view cell that the user has clicked
    if ([self.ratingTableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryNone) {
        //setting accessory type to checkmark
        [self.ratingTableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        self.selectedStar = (indexPath.row + 1) * 2;
        [self.ratingTableView reloadData];
        NSLog(@"%ld", self.selectedStar);
    }
    else if ([self.ratingTableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark){
        //check mark already there make it to none
        self.selectedStar = NULL;
        [self.ratingTableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
        [self.ratingTableView reloadData];
        NSLog(@"%ld", self.selectedStar);
    }
    else{
        //setting default to none
        [self.ratingTableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
        [self.ratingTableView reloadData];
    }
}

-(void)getUserDetails{
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSURLSession *session = [NSURLSession sharedSession];
        NSString *urlString = @"http://burst.co.in/preview/USERLOCATION.php";
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            //Getting the data from the JSon file
            NSData *data = [[NSData alloc] initWithContentsOfURL:location];
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                               options:kNilOptions error:nil];
            
            NSArray *userLocationArray = [responseDictionary objectForKey:@"userLocation"];
            self.userLocation = [NSMutableArray array];
            
            for(NSDictionary *ulDictionary in userLocationArray){
                PRUserLocation *userLocation = [[PRUserLocation alloc] init];
                userLocation.city = [ulDictionary objectForKey:@"city"];
                userLocation.country = [ulDictionary objectForKey:@"country"];
                userLocation.latitude = [ulDictionary objectForKey:@"latitude"];
                userLocation.longitude = [ulDictionary objectForKey:@"longitude"];
                userLocation.postalCode = [ulDictionary objectForKey:@"postal_code"];
                userLocation.timeZone = [ulDictionary objectForKey:@"timezone"];
                userLocation.regionCode = [ulDictionary objectForKey:@"region_code"];
                userLocation.countryCode = [ulDictionary objectForKey:@"country_code"];
                userLocation.asn = [ulDictionary objectForKey:@"asn"];
                
                [self.userLocation addObject:userLocation];
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.view reloadInputViews];
            });
            
        }];
        [task resume];

    }
}

-(void)sendStarRatingWithProductId:(NSString *)productId andCommentId:(NSString *)commentId{
    NSURL *sendStarRatingURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://burst.co.in/preview/send_star_rating.php?type=put&product_id=%@&stars=%ld&comment_id=%@", productId, self.selectedStar,commentId]];
    NSLog(@"%@", sendStarRatingURL);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:sendStarRatingURL];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data.length > 0 && connectionError == nil) {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            //NSLog(@"%@", responseDictionary[@"status"]);
            if ([responseDictionary[@"status"] isEqualToString:@"success"]) {
                NSLog(@"Request is sent");
            }
        }
        else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[connectionError.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
            NSLog(@"%@", connectionError);
        }
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
