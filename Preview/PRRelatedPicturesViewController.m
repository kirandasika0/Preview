//
//  PRRelatedPicturesViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 05/06/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRRelatedPicturesViewController.h"
#import "PRFeedPost.h"
#import "PRCollectionCell.h"
#import "PRShowOriginalPictureViewController.h"
#import "SAMCache.h"

@interface PRRelatedPicturesViewController ()

@end

@implementation PRRelatedPicturesViewController


-(instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(106.0, 106.0);
    layout.minimumInteritemSpacing = 1.0;
    layout.minimumLineSpacing = 1.0;
    return (self = [super initWithCollectionViewLayout:layout]);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *dismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
    dismiss.numberOfTapsRequired = 2;
    
    [self.collectionView addGestureRecognizer:dismiss];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@",self.productName);
    [self refresh];
    
}

-(void)refresh {
    [self.activityInd startAnimating];
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *urlString = [[NSString alloc] initWithFormat:@"http://www.burst.co.in/preview/related_pics_json.php?product_id=%@",self.productUniqueID];
    //NSLog(@"%@",urlString);
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:kNilOptions error:nil];
        
        NSArray *feedPostsArray = [responseDictionary objectForKey:@"pictures"];
        self.allPics = [NSMutableArray array];
        
        for (NSDictionary *fdDictionary in feedPostsArray) {
            //We have to add all the object to the feed posts mutable array.
            self.imageOriginal = [fdDictionary objectForKey:@"image_original"];
            self.imageThumbnail = [fdDictionary objectForKey:@"image_thumbnail"];
            
           //We have to link these also in the feed post class file.
            PRFeedPost *feedPost = [[PRFeedPost alloc] init];
            feedPost.relatedPictureOriginal = [fdDictionary objectForKey:@"image_original"];
            feedPost.relatedPictureThumbnail = [fdDictionary objectForKey:@"image_thumbnail"];
            feedPost.relatedPictureId = [fdDictionary objectForKey:@"id"];
            [self.allPics addObject:feedPost];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            if ([self.allPics count] <= 0) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Looks like there aren't any pictures available.Please try later" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
                [alertView show];
            }
            [self.activityInd stopAnimating];
        });
    }];
    [task resume];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.allPics count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PRCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    PRFeedPost *relatedPicFeedPost = [self.allPics objectAtIndex:indexPath.row];
    NSURL *thumbnailURL = [NSURL URLWithString:relatedPicFeedPost.relatedPictureThumbnail];
    
    //Using Samcache
    NSString *key = [NSString stringWithFormat:@"%@-thumbnail",relatedPicFeedPost.relatedPictureId];
    UIImage *photo = [[SAMCache sharedCache] imageForKey:key];
    if (photo) {
        cell.imageView.image = photo;
        
    }
    else{
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            NSData *thumbnailData = [NSData dataWithContentsOfURL:thumbnailURL];
            if (thumbnailData != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.imageView.image = [UIImage imageWithData:thumbnailData];
                    [[SAMCache sharedCache] setImage:[UIImage imageWithData:thumbnailData] forKey:key];
                });
            }
        });
    }
    
    //Styling cell
    /*[cell.layer setBorderWidth:2.0f];
    [cell.layer setBorderColor:[UIColor whiteColor].CGColor];
    [cell.layer setCornerRadius:50.0f]; */
    
    
    [cell.layer setBorderWidth:1.0f];
    [cell.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *indexPaths = [NSMutableArray arrayWithObject:indexPath];
    
    if (self.selectedItemIndexPath) {
        
        if ([indexPath compare:self.selectedItemIndexPath] == NSOrderedSame) {
            
            self.selectedItemIndexPath = nil;
        }
        else{
            [indexPaths addObject:self.selectedItemIndexPath];
            self.selectedItemIndexPath = indexPath;
            [self performSegueWithIdentifier:@"showPicture" sender:self];
        }
    }
    else{
        self.selectedItemIndexPath = indexPath;
        [self performSegueWithIdentifier:@"showPicture" sender:self];
    }
    
    [collectionView reloadItemsAtIndexPaths:indexPaths];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showPicture"]) {
        PRFeedPost *feedPost = [self.allPics objectAtIndex:self.selectedItemIndexPath.row];
        PRShowOriginalPictureViewController *modalViewController = (PRShowOriginalPictureViewController *)segue.destinationViewController;
        modalViewController.productName = self.productName;
        modalViewController.orignalImageString = feedPost.relatedPictureOriginal;
}
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    //We have to take this to the modal view controller that is done in the code
    //NSDictionary *photo = self.allPics[indexPath.row];
    
}

-(void)dismissView {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != [alertView cancelButtonIndex]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
