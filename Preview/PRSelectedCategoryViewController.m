//
//  PRSelectedCategoryViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 11/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRSelectedCategoryViewController.h"
#import <Parse/Parse.h>
#import "PRSelectedCategoryTitles.h"

@interface PRSelectedCategoryViewController ()

@end

@implementation PRSelectedCategoryViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"Username: %@",currentUser.username);
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
    NSURL *url = [NSURL URLWithString:self.emitterFileURL];
    
    NSData *jsonFeedData = [NSData dataWithContentsOfURL:url];
    
    NSDictionary *feedDictionary = [NSJSONSerialization JSONObjectWithData:jsonFeedData options:0 error:nil];
    
    self.feedPost = [NSMutableArray array];
    
    NSArray *feedPostsArray = [feedDictionary objectForKey:@"selected_category"];
    
    for (NSDictionary *scgsDictionary in feedPostsArray) {
        PRSelectedCategoryTitles *catTitles = [PRSelectedCategoryTitles blogPostWithTitle:[scgsDictionary objectForKey:@"product_name"]];
        catTitles.decp = [scgsDictionary objectForKey:@"product_decp"];
        catTitles.rating = [scgsDictionary objectForKey:@"rating"];
        [self.feedPost addObject:catTitles];
    }
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
    return [self.feedPost count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
   // PRSelectedCategoryTitles *catTitles = [self.feedPost objectAtIndex:indexPath.row];
    
    PRSelectedCategoryTitles *catTitles = [self.feedPost objectAtIndex:indexPath.row];
    
    cell.textLabel.text = catTitles.title;
    
    NSString *fullRatingString = [NSString stringWithFormat:@"Preview Rating: %@ / 10",catTitles.rating];
    
    cell.detailTextLabel.text = fullRatingString;
    
    return cell;
}

- (IBAction)swipedRight:(id)sender {
    NSLog(@"Just swiped right !");
}
@end