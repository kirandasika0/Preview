//
//  PRForgotPasswordViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 20/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRForgotPasswordViewController.h"

@interface PRForgotPasswordViewController ()

@end

@implementation PRForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //we are doing everything in the view will appear
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (IBAction)forgotPassword:(id)sender {
    NSString *email = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (email.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Looks like you did not type the email in the field." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        
    }
    else{
        [PFUser requestPasswordResetForEmailInBackground:email block:^(BOOL succeeded, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error." message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alertView show];
            }
            else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"An Email has been sent to email that you have typed please check it." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alertView show];
            }
        }];
    }
}

- (IBAction)closeForgotPassword:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
