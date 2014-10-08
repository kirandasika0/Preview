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

@interface PRRelatedPicturesViewController ()

@end

@implementation PRRelatedPicturesViewController


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
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *urlString = [[NSString alloc] initWithFormat:@"http://www.burst.co.in/preview/related_pics_json.php?product_id=%@",self.productUniqueID];
    NSLog(@"%@",urlString);
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
            
            [self.allPics addObject:feedPost];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
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
    NSData *thumbnailData = [NSData dataWithContentsOfURL:thumbnailURL];
    cell.imageView.image = [UIImage imageWithData:thumbnailData];
    
    //Styling cell
    [cell.layer setBorderWidth:2.0f];
    [cell.layer setBorderColor:[UIColor whiteColor].CGColor];
    [cell.layer setCornerRadius:50.0f];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    //We have to take this to the modal view controller that is done in the code
    //NSDictionary *photo = self.allPics[indexPath.row];
    
}

-(void)dismissView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
