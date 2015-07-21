//
//  PRLeaderBoardViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 22/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRLeaderBoardViewController.h"
#import "PRLeaderboardViewCell.h"
#import "PRShowAllReviewsViewController.h"

@interface PRLeaderBoardViewController ()

@end

@implementation PRLeaderBoardViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.currentUser = [PFUser currentUser];
    [self getUsers];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.allUsers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PRLeaderboardViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFUser *userObject = [self.allUsers objectAtIndex:indexPath.row];
    // Configure the cell...
    [cell configureCellForEntry:userObject];
    return cell;
}

-(void)getUsers{
    PFQuery *query = [PFUser query];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.allUsers = objects;
            [self.tableView reloadData];
        }
        else{
            NSLog(@"%@", [error.userInfo objectForKey:@"error"]);
        }
    }];
}

#pragma mark - Segue Methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showAllReviews"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PFUser *userObject = [self.allUsers objectAtIndex:indexPath.row];
        PRShowAllReviewsViewController *pushViewController = (PRShowAllReviewsViewController *)segue.destinationViewController;
        pushViewController.userOBJID = userObject.objectId;
    }
}

@end
