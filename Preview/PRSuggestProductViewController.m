//
//  PRSuggestProductViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 11/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRSuggestProductViewController.h"

@interface PRSuggestProductViewController ()

@end

@implementation PRSuggestProductViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /*
    [self.navigationController.navigationBar setTranslucent:YES];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
     */
}

- (IBAction)suggestProduct:(id)sender {
    NSString *suggestProduct = [self.suggestProductField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([suggestProduct length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Looks like you did not type something" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
    else {
        //We can upload to the backend
        //We are using the parse api and making the user suggest a product to us.
        PFObject *suggestedProductObject = [PFObject objectWithClassName:@"suggestedProducts"];
        suggestedProductObject[@"productName"] = suggestProduct;
        [suggestedProductObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                NSLog(@"There was an error while saving the suggesting product.");
            }
            else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Your Product will be Reviewed by our preview Team and will be appearing in a few days." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alertView show];
            }
        }];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
@end
