//
//  PRLoginViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 10/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRLoginViewController.h"
#import <Parse/Parse.h>

@interface PRLoginViewController ()

@end

@implementation PRLoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
}
-(void)viewWillAppear:(BOOL)animated  {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}




- (IBAction)login:(id)sender {
    //We can log the user here.
    NSString *usernameField = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *passwordField = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (usernameField == 0 || passwordField == 0) {
        //We have to show an alert to the user.
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Looks like your have missed some fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else {
        //We can log the user
        [PFUser logInWithUsernameInBackground:usernameField password:passwordField block:^(PFUser *user, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error 403" message:[error.userInfo objectForKey:@"error"]delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
            else {
                //Now the user can go to the home page.
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }
}

- (IBAction)openContactUsPage:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://burst.co.in/preview/contact_us.php"]];
}
@end
