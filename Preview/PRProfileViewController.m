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

@interface PRProfileViewController ()

@end

@implementation PRProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.currentUser = [PFUser currentUser];
    
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
    //query the database to get the picture
    PFQuery *queryForPic = [PFUser query];
    [queryForPic whereKey:@"objectId" equalTo:currentUser.objectId];
    [queryForPic findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Problem with the query.");
        }
        else{
            for(PFObject *profilePictureObject in objects)
            {
                //Caching the picture
                NSString *key = [NSString stringWithFormat:@"%@-dp",[[PFUser currentUser] objectId]];
                UIImage *photo = [[SAMCache sharedCache] imageForKey:key];
                if (photo) {
                    self.profilePictureImageView.image = photo;
                }
                //Setting the profile picture
                PFFile *file = [profilePictureObject objectForKey:@"pro_pic"];
                NSURL *url = [NSURL URLWithString:file.url];
                NSData *imageData = [NSData dataWithContentsOfURL:url];
                UIImage *image = [UIImage imageWithData:imageData];
                [[SAMCache sharedCache] setImage:image forKey:key];
                self.profilePictureImageView.image = image;
                self.profilePictureImageView.layer.cornerRadius = CGRectGetWidth(self.profilePictureImageView.frame) / 2.0f;
                //Setting the cover picture
                //Key for cover picture
                NSString *keyForCoverPic = [NSString stringWithFormat:@"%@-cp",[[PFUser currentUser] objectId]];
                UIImage *cpImage = [[SAMCache sharedCache] imageForKey:key];
                if (cpImage) {
                    self.coverImageView.image = cpImage;
                }
                PFFile *coverPictureFile = [profilePictureObject objectForKey:@"cover_pic"];
                NSURL *urlForCoverPic = [NSURL URLWithString:coverPictureFile.url];
                NSData *coverPictureData = [NSData dataWithContentsOfURL:urlForCoverPic];
                UIImage *coverImage = [UIImage imageWithData:coverPictureData];
                //Caching the image
                [[SAMCache sharedCache] setImage:coverImage forKey:keyForCoverPic];
                self.coverImageView.image = coverImage;
            }
        }
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.userReviews count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *review = [self.userReviews objectAtIndex:indexPath.row];
    cell.textLabel.text = [review objectForKey:@"username"];
    NSLog(@"%@",[review objectForKey:@"username"]);
    cell.detailTextLabel.text = [review objectForKey:@"comment"];
    return cell;
}


-(void)getUserReviews{
    PFQuery *query = [PFQuery queryWithClassName:@"comments"];
    [query whereKey:@"user_id" equalTo:self.currentUser];
    //query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.userReviews = objects;
            //NSLog(@"%@",self.userReviews);
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showEditProfile"]) {
        [self.tabBarController setHidesBottomBarWhenPushed:YES];
    }
}

- (IBAction)openRelatedSearches:(id)sender {
    PRRelatedViewController *viewController = [[PRRelatedViewController alloc] init];
    [self presentViewController:viewController animated:YES completion:nil];
}
@end
