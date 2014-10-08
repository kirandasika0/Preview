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

@interface PRCategoryViewController ()

@end

@implementation PRCategoryViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated {
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
    } else {
        cell.imageView.image = [UIImage imageNamed:@"export"];
    }
    
    cell.textLabel.text = feedPost.title;
    
    
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

@end
