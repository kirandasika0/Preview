//
//  PRShowAllReviewsViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 04/11/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRShowAllReviewsViewController.h"
#import "PRShowReviewViewCell.h"

@interface PRShowAllReviewsViewController ()

@end

@implementation PRShowAllReviewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getAllReviews) forControlEvents:UIControlEventValueChanged];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getAllReviews];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.allReviews count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PRShowReviewViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    // Configure the cell...
    PFObject *reviewObject = [self.allReviews objectAtIndex:indexPath.row];
    cell.userFullNameLabel.text = [reviewObject objectForKey:@"fullName"];
    cell.reviewLabel.text = [reviewObject objectForKey:@"comment"];
    cell.reviewLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.reviewLabel.numberOfLines = 0;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //PRShowReviewViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    CGFloat height = 140;
    
    return height;
}

-(void)getAllReviews{
    PFQuery *query = [PFQuery queryWithClassName:@"comments"];
    [query whereKey:@"user_id" equalTo:self.userOBJID];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error.");
        }
        else {
            self.allReviews = objects;
            NSLog(@"%@",self.allReviews);
            [self.tableView reloadData];
        }
    }];
    if ([self.refreshControl isRefreshing]) {
        [self.refreshControl endRefreshing];
    }
}

@end
