//
//  PRcommentsCollectionViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 04/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRcommentsCollectionViewController.h"
#import "PRCommentsCollectionViewCell.h"

@interface PRcommentsCollectionViewController ()

@end

@implementation PRcommentsCollectionViewController

static NSString * const reuseIdentifier = @"CommentCell";


- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UITapGestureRecognizer *twoTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeComments)];
    twoTaps.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:twoTaps];
    [self getComments];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getComments) forControlEvents:UIControlEventValueChanged];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.comments count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PRCommentsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // Configure the cell
    PFObject *commentObject = [self.comments objectAtIndex:indexPath.row];
    [cell configureCellForEntry:commentObject];
    return cell;
}

-(void)getComments{
    PFQuery *query = [PFQuery queryWithClassName:@"comments"];
    [query whereKey:@"product_id" equalTo:self.productUniqueID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error.");
        }
        else {
            self.comments = objects;
            for (PFObject *comment in self.comments) {
                NSLog(@"%@",comment);
            }
            [self.collectionView reloadData];
        }
    }];
}

-(void)closeComments{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
