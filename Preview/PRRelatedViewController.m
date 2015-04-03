//
//  PRRelatedViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 29/03/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import "PRRelatedViewController.h"

@interface PRRelatedViewController ()

@end

@implementation PRRelatedViewController

-(instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(106.0, 106.0);
    layout.minimumInteritemSpacing = 1.0;
    layout.minimumLineSpacing = 1.0;
    return (self = [super initWithCollectionViewLayout:layout]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"photo"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //Long Press
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [longPress setMinimumPressDuration:1];
    [self.collectionView addGestureRecognizer:longPress];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fetchSeenProducts];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}

-(void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)fetchSeenProducts{
    PFQuery *query = [PFQuery queryWithClassName:@"seenProducts"];
    [query whereKey:@"userID" equalTo:[[PFUser currentUser] objectId]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@",[error.userInfo objectForKey:@"error"]);
        }
        else{
            self.seenProducts = objects;
            NSLog(@"Fetched Products");
            //Run the getMostFreqeust Method to populate the product_id array
            [self getMostFrequent];
        }
    }];
}


-(void)getMostFrequent{
    for(PFObject *object in self.seenProducts){
        self.mostFrequentArray = [object objectForKey:@"product_category"];
        //NSLog(@"%@",[object objectForKey:@"product_id"]);
    }
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
