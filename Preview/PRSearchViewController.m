//
//  PRSearchViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 31/07/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import "PRSearchViewController.h"
#import "AFNetworking.h"
#import "PRSearchCell.h"
#import "PRDetailSearchResultViewController.h"
#import "PRColorWheel.h"

@interface PRSearchViewController ()

@end

@implementation PRSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.alpha = 0.3;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.resultsArray = [[NSMutableArray alloc] init];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.previewSearchBar.delegate = self;
    NSLog(@"%lu", (unsigned long)self.resultsArray.count);
    self.tableView.tableFooterView = [UIView new];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:1.0 animations:^{
        self.tableView.alpha = 1.0;
    } completion:nil];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"%@", searchBar.text);
    self.searchString = searchBar.text;
    if (self.searchString.length >= 3) {
        [self.view endEditing:YES];
    }
    //send request to server only when something goood is typed
    if (self.searchString.length >= 3 && self.searchString.length != 0) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"search_string": self.searchString};
        //showing the network indicator
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [manager POST:@"https://preview-backend.herokuapp.com/backend/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //hiding the network indicator
            //NSLog(@"%@", responseObject);
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            //clearing the mutablearray if there are any results
            if ([self.resultsArray count] != 0) {
                [self.resultsArray removeAllObjects];
            }
            
            for (NSDictionary *product in responseObject[@"results"]) {
                [self.resultsArray addObject:product]; //adding the results into a mutable array
            }
            
            [self.tableView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else{
        NSLog(@"Please type in a bigger word.");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Your search term must be 3 or more than 3 charecters." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.resultsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PRSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if ([self.resultsArray count] != 0) {
        NSDictionary *product = [self.resultsArray objectAtIndex:indexPath.row];
        cell.backgroundColor = [[[PRColorWheel alloc] init] randomColor];
        //we have suclassed the uitablviewcell the SearchCell and that will configure the cell with appropriate data
        [cell configureCellForProduct:product];
    }
    // Configure the cell...
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //segue to the detail search product controller
    NSDictionary *product = [self.resultsArray objectAtIndex:indexPath.row];
    self.selectedProduct = product;
    if ([product[@"product_name"] length] > 0) {
        [self performSegueWithIdentifier:@"showDetailSearch" sender:self];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showDetailSearch"]) {
        PRDetailSearchResultViewController *viewController = (PRDetailSearchResultViewController *)segue.destinationViewController;
        viewController.product = self.selectedProduct;
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
}
- (IBAction)closeKeyboard:(id)sender {
    //check if the keyboard is there then close
    if ([self.view isFirstResponder]) {
        [self.view resignFirstResponder];
    }
}
@end
