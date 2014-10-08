//
//  PRFriendsCollectionViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 02/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRFriendsCollectionViewController.h"
#import "PRFriendsCollectionViewCell.h"

@interface PRFriendsCollectionViewController ()

@end

@implementation PRFriendsCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(150.0, 150.0);
    layout.minimumInteritemSpacing = 1.0;
    layout.minimumLineSpacing = 1.0;
    
    return (self = [super initWithCollectionViewLayout:layout]);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getUsers];
    [[self tabBarItem] setBadgeValue:self.numberOfUsers];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete method implementation -- Return the number of items in the section
    return [self.allUsers count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PRFriendsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // Configure the cell
    PFUser *objectForEachUser = [self.allUsers objectAtIndex:indexPath.row];
    cell.usersNameLabel.text = objectForEachUser.username;
    return cell;
}

#pragma mark <UICollectionViewDelegate>
-(void)getUsers {
    PFQuery *query = [PFUser query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Problem while getting the users.");
        }
        else {
            self.allUsers = objects;
            [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
                self.numberOfUsers = [NSString stringWithFormat:@"%d",number];
            }];
            [self.collectionView reloadData];
        }
    }];
}
@end
