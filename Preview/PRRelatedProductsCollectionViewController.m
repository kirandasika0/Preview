//
//  PRRelatedProductsCollectionViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 22/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRRelatedProductsCollectionViewController.h"
#import "PRRelatedSearchCollectionViewCell.h"
#import "PRRelatedVariables.h"
#import "PRDetailRelatedPostViewController.h"

@interface PRRelatedProductsCollectionViewController ()

@end

@implementation PRRelatedProductsCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.currentUser = [PFUser currentUser];
    [self getRelatedProducts];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.allProducts count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PRRelatedSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    PRRelatedVariables *feedPosts = [self.allProducts objectAtIndex:indexPath.row];
    cell.productnameLabel.text = feedPosts.productName;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSString *imageURLString = feedPosts.imageURL;
        NSURL *imageURL = [NSURL URLWithString:imageURLString];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        if (imageData != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                 UIImage *image = [UIImage imageWithData:imageData];
                cell.productPictureImageView.image = image;
            });
        }
        else {
            cell.productPictureImageView.image = [UIImage imageNamed:@"tabBarBackgound"];
        }
        
    });
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PRRelatedVariables *feedPost = [self.allProducts objectAtIndex:indexPath.row];
    NSLog(@"%@",feedPost.productName);
    if (feedPost.productName != 0) {
        [self performSegueWithIdentifier:@"showDetailRelatedSearch" sender:self];
    }
}

-(void)getRelatedProducts{
    PFQuery *query = [PFQuery queryWithClassName:@"seenProducts"];
    [query whereKey:@"userID" equalTo:self.currentUser.objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error");
        }
        else{
            NSArray *fullSeenProductsArray = objects;
            NSMutableArray *categoryArray = [fullSeenProductsArray mutableArrayValueForKey:@"product_category"];
            NSCountedSet *stringSet = [[NSCountedSet alloc] initWithArray:categoryArray];
            NSString *mostCommon = nil;
            NSUInteger highestCount = 0;
            for (NSString *category in stringSet) {
                NSUInteger count = [stringSet countForObject:category];
                if (count > highestCount) {
                    highestCount = count;
                    mostCommon = category;
                    NSURLSession *session = [NSURLSession sharedSession];
                    NSString *urlString = [[NSString alloc] initWithFormat:@"http://www.burst.co.in/preview/related_search_json.php?id=%@",mostCommon];
                    NSLog(@"%@",urlString);
                    NSURL *url = [[NSURL alloc] initWithString:urlString];
                    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
                    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
                        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                           options:kNilOptions error:nil];
                        
                        NSArray *feedPostsArray = [responseDictionary objectForKey:@"related"];
                        self.allProducts = [NSMutableArray array];
                        for (NSDictionary *fdDictionary in feedPostsArray)
                        {
                            PRRelatedVariables *feedPost = [[PRRelatedVariables alloc] init];
                            feedPost.productName = [fdDictionary objectForKey:@"product_name"];
                            feedPost.productDecp = [fdDictionary objectForKey:@"product_decp"];
                            feedPost.imageURL = [fdDictionary objectForKey:@"product_original"];
                            feedPost.productUniqueID = [fdDictionary objectForKey:@"id"];
                            [self. allProducts addObject:feedPost];
                        }
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.collectionView reloadData];
                        });
                    }];
                    [task resume];
                }
         
            }
        }
    }];
}

#pragma mark - Segue Methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showDetailRelatedSearch"]) {
        NSIndexPath *indexPath =
        [self.collectionView indexPathForItemAtPoint:
         [self.view convertPoint:[self.view center] toView:self.collectionView]];
        PRRelatedVariables *feedPost = [self.allProducts objectAtIndex:indexPath.row];
        PRDetailRelatedPostViewController *pushViewController = (PRDetailRelatedPostViewController *)segue.destinationViewController;
        pushViewController.productName = feedPost.productName;
        pushViewController.productDecp = feedPost.productDecp;
        pushViewController.imageURLString = feedPost.imageURL;
    }
}

@end
