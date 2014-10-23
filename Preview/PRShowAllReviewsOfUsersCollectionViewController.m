//
//  PRShowAllReviewsOfUsersCollectionViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 23/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRShowAllReviewsOfUsersCollectionViewController.h"
#import "PRShowAllReviewsOfUsersCollectionViewCell.h"

@interface PRShowAllReviewsOfUsersCollectionViewController ()

@end

@implementation PRShowAllReviewsOfUsersCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.allReviews count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PRShowAllReviewsOfUsersCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    PFObject *review = [self.allReviews objectAtIndex:indexPath.row];
    cell.reviewLabel.text = [review objectForKey:@"comment"];
    cell.reviewLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.reviewLabel.numberOfLines = 0;
    return cell;
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
            [self.collectionView reloadData];
        }
    }];
}

@end
