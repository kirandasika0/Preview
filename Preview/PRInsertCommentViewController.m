//
//  PRInsertCommentViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 04/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRInsertCommentViewController.h"
#import "PRUserLocation.h"

@interface PRInsertCommentViewController ()

@end

@implementation PRInsertCommentViewController
@synthesize ratingTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentUser = [PFUser currentUser];
    self.ratingParas = [NSMutableArray arrayWithObjects:@"1 Star",@"2 Stars",@"3 Stars",@"4 Stars",@"5 Stars", nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UITapGestureRecognizer *closeInsertPost = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeViewController)];
    closeInsertPost.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:closeInsertPost];
    //[self.ratingTableView reloadData];
    [self getUserDetails];
}


- (IBAction)insertComment:(id)sender {
    NSString *comment = [self.commentTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([comment length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Looks like you have'nt typed anything in the comment text box." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else {
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
                NSLog(@"Error.");
            }
            else {
                //[self dismissViewControllerAnimated:YES completion:nil];
                NSLog(@"Uploaded.");
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    }
}
-(void)closeViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table View Methods
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
                
            });
            
        }];
        [task resume];

    }
}

@end
