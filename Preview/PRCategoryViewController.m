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
    //[self loadData];
    
    [self loadCategories];
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
    
    PFObject *category = [self.categoryTitles objectAtIndex:indexPath.row];
    
    
    NSLog(@"%@", category[@"category_name"]);
    
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
-(void)loadCategories{
    //send reqeust to the json file to get products
    NSURL *categoriesURL = [NSURL URLWithString:@"http://burst.co.in/preview/json_emitter_2.php"];
    NSURLRequest *categoriesRequest = [NSURLRequest requestWithURL:categoriesURL];
    
    [NSURLConnection sendAsynchronousRequest:categoriesRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //checking for errors
        if (data.length > 0 && connectionError == nil) {
            //we have got the data
            //this is the main dictionary that is holding the key of fetches
            NSDictionary *mainDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            //an array with all category titles
            self.categoryTitles = [mainDictionary objectForKey:@"fetches"];
//            for (PFObject *category in self.categoryTitles) {
//                NSLog(@"%@", category[@"category_name"]);
//            }
        }
        else{
            NSLog(@"There was an error in getting the data from the server.");
        }
    }];
    
}
@end
