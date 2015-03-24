//
//  PRCategoryViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 10/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRCategoryViewController.h"
#import "PRCategoryTitles.h"
#import "PRSelectedCategoryViewController.h"
#import <iAd/iAd.h>
#import <QuartzCore/QuartzCore.h>
#import "AFNetworking.h"

@interface PRCategoryViewController ()

@end

@implementation PRCategoryViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated {
    /*
    [super viewWillAppear:animated];
    NSURL *feedURL = [NSURL URLWithString:@"http://www.burst.co.in/preview/json_emitter_2.php"];
    
    NSData *jsonFeedData = [NSData dataWithContentsOfURL:feedURL];
    
    NSDictionary *feedDictionary = [NSJSONSerialization JSONObjectWithData:jsonFeedData options:0 error:nil];
    
    self.categoryPost = [NSMutableArray array];
    
    NSArray *feedPostsArray = [feedDictionary objectForKey:@"fetches"];
    
    for (NSDictionary *cgDictionary in feedPostsArray) {
        PRCategoryTitles *feedPost = [PRCategoryTitles blogPostWithTitle:[cgDictionary objectForKey:@"category_name"]];
        feedPost.thumbnail = [cgDictionary objectForKey:@"category_icon_32"];
        feedPost.emitterURL = [cgDictionary objectForKey:@"emitter_file"];
        [self.categoryPost addObject:feedPost];
    }
     */
    [self loadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.categoryPost count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PRCategoryTitles *feedPost = [self.categoryPost objectAtIndex:indexPath.row];
    
    if ( [feedPost.thumbnail isKindOfClass:[NSString class]]) {
        NSData *imageData = [NSData dataWithContentsOfURL:feedPost.thumbnailURL];
        UIImage *image = [UIImage imageWithData:imageData];
        cell.imageView.image = image;
        cell.imageView.layer.cornerRadius = CGRectGetWidth(cell.imageView.frame) / 2.0f;
        
    } else {
        cell.imageView.image = [UIImage imageNamed:@"export"];
    }
    
    cell.textLabel.text = feedPost.title;
    NSLog(@"%@",feedPost.title);
    
    return cell;
}

#pragma mark - Segue Methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showSelected"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PRCategoryTitles *feedPost = [self.categoryPost objectAtIndex:indexPath.row];
        PRSelectedCategoryViewController *selectedCategoryViewController = (PRSelectedCategoryViewController *)segue.destinationViewController;
        selectedCategoryViewController.emitterFileURL = feedPost.emitterURL;
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
    if ([segue.identifier isEqualToString:@"showAddProduct"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
}

#pragma  mark - Start App Ads
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (bannerView == nil) {
        bannerView = [[STABannerView alloc] initWithSize:STA_AutoAdSize autoOrigin:STAAdOrigin_Bottom withView:self.tableView withDelegate:nil];
        [self.tableView addSubview:bannerView];
    }
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [bannerView didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}
//For iOS 8
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [bannerView viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

#pragma mark - iAd Banner Methods
/*
-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    [UIView commitAnimations];
}
-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
}
*/
-(void)loadData{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    //Setting the NSURL
    NSURL *url = [NSURL URLWithString:@"http://burst.co.in/preview/json_emitter_2.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //Data task
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        else {
            //NSLog(@"%@",responseObject);
            self.categoryPost = [NSMutableArray array];
            NSArray *feedPostsArray = [responseObject objectForKey:@"fetches"];
            for(NSDictionary *cgDictionary in feedPostsArray){
                PRCategoryTitles *feedPost = [PRCategoryTitles blogPostWithTitle:[cgDictionary objectForKey:@"category_name"]];
                feedPost.thumbnail = [cgDictionary objectForKey:@"category_icon_32"];
                feedPost.emitterURL = [cgDictionary objectForKey:@"emitter_file"];
                [self.categoryPost addObject:feedPost];
                NSLog(@"%@",self.categoryPost);
                
            }
        }
    }];
    [dataTask resume];
}
@end
