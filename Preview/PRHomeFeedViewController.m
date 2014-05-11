//
//  PRHomeFeedViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 10/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRHomeFeedViewController.h"
#import "PRFeedPost.h"
#import "PRModalDetailFeedViewController.h"

@interface PRHomeFeedViewController ()

@end

@implementation PRHomeFeedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSLog(@"Current User: %@", currentUser.username);
    }
    else {
        [self performSegueWithIdentifier:@"showLogin" sender:nil];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //We have to update the app every time we see the view
    
    NSURL *feedURL = [NSURL URLWithString:@"http://www.burst.co.in/preview/json_emitter_1.php"];
    
    NSData *jsonFeedData = [NSData dataWithContentsOfURL:feedURL];
    
    NSDictionary *feedDictionary = [NSJSONSerialization JSONObjectWithData:jsonFeedData options:0 error:nil];
    
    self.feedPosts = [NSMutableArray array];
    
    NSArray *feedPostsArray = [feedDictionary objectForKey:@"posts"];
    
    for (NSDictionary *fdDictionary in feedPostsArray) {
        PRFeedPost *feedPost = [PRFeedPost blogPostWithTitle:[fdDictionary objectForKey:@"product_name"]];
        feedPost.category = [fdDictionary objectForKey:@"product_category"];
        feedPost.thumbnail = [fdDictionary objectForKey:@"product_thumbnail"];
        feedPost.decp = [fdDictionary objectForKey:@"product_decp"];
        feedPost.rating = [fdDictionary objectForKey:@"product_rating"];
        feedPost.uniqueID = [fdDictionary objectForKey:@"id"];
        
        [self.feedPosts addObject:feedPost];
    }
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.feedPosts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PRFeedPost *feedPost = [self.feedPosts objectAtIndex:indexPath.row];

    cell.textLabel.text = feedPost.title;
    if ([feedPost.category isEqualToString:@"1"]) {
        cell.detailTextLabel.text = @"Movie";
    }
    if ([feedPost.category isEqualToString:@"2"]) {
        cell.detailTextLabel.text = @"Lifestyle";
    }
    if ([feedPost.category isEqualToString:@"3"]) {
        cell.detailTextLabel.text = @"Video Games";
    }
    if ([feedPost.category isEqualToString:@"4"]) {
        cell.detailTextLabel.text = @"Music";
    }
    if ([feedPost.category isEqualToString:@"5"]) {
        cell.detailTextLabel.text = @"Gadgets";
    }
    if ([feedPost.category isEqualToString:@"6"]) {
        cell.detailTextLabel.text = @"Books";
    }
    
    if ([feedPost.thumbnail isKindOfClass:[NSString class]]) {
        NSData *imageData = [NSData dataWithContentsOfURL:feedPost.thumbnailURL];
        UIImage *image = [UIImage imageWithData:imageData];
        cell.imageView.image = image;
    }
    else {
        //cell.imageView.image = [UIImage imageNamed:@"export"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PRFeedPost *feedPost = [self.feedPosts objectAtIndex:indexPath.row];
    NSLog(@"%@",feedPost.title);
    if (feedPost.title != 0) {
        [self performSegueWithIdentifier:@"showDetailPostFeed" sender:self];
    }
    else {
        //We are gonna do nothing for now.
    }
}

- (IBAction)logout:(id)sender {
    //We should now log the user out.
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showLogin" sender:nil];
}

#pragma mark - Main Segue Methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showLogin"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
    if ([segue.identifier isEqualToString:@"showDetailPostFeed"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PRFeedPost *feedPost = [self.feedPosts objectAtIndex:indexPath.row];
        PRModalDetailFeedViewController *modalViewController = (PRModalDetailFeedViewController *)segue.destinationViewController;
        
        modalViewController.productName = feedPost.title;
        modalViewController.productCategory = feedPost.category;
        modalViewController.productDecp = feedPost.decp;
        modalViewController.productRating  = feedPost.rating;
        modalViewController.productUniqueID = feedPost.uniqueID;
        
        
        
        NSData *imageData = [NSData dataWithContentsOfURL:feedPost.thumbnailURL];
        modalViewController.thumbImageData = imageData;
        //we have sent all the data to the modal view controller
        
        
    }
}

@end
