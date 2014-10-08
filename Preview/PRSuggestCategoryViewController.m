//
//  PRSuggestCategoryViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 11/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRSuggestCategoryViewController.h"

@interface PRSuggestCategoryViewController ()

@end

@implementation PRSuggestCategoryViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	
}



- (IBAction)suggestCategory:(id)sender {
    NSString *suggestCategory = [self.suggestCategoryField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([suggestCategory length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Looks like you did not type something" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
    else {
        //We can upload to the backend
        //setting up the PFObject
        PFObject *suggestCategoryObject = [PFObject objectWithClassName:@"suggestCategory"];
        suggestCategoryObject[@"categoryName"] = suggestCategory;
        [suggestCategoryObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                NSLog(@"Looks like there was a prblem while saving something in the backend.");
                
            }
            else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"The Category you have suggested has been sent to our team. Please wait for a few days as our team has to review the product and upload it. Thanks For your Time. :)" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil];
                [alertView show];
            }
        }];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }

}
@end
