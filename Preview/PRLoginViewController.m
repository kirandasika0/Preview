//
//  PRLoginViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 10/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRLoginViewController.h"
#import <Parse/Parse.h>
#import "UIImageEffects.h"

@interface PRLoginViewController ()

@end

@implementation PRLoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    
    UIImage *backgroundImage = [UIImage imageNamed:@"tabBarBackground"];
    UIImage *effectImage = [UIImageEffects imageByApplyingBlurToImage:backgroundImage withRadius:30.0 tintColor:[UIColor colorWithWhite:1 alpha:0.2] saturationDeltaFactor:1.5 maskImage:nil];
    self.backgoundImageView.image = effectImage;
    
}
-(void)viewWillAppear:(BOOL)animated  {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    self.usernameField.alpha = 0.0;
    self.passwordField.alpha = 0.0;
    self.loginButton.alpha = 0.0;
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //having a ease in affect of the app
    [UIView animateWithDuration:1.2 animations:^{
        self.usernameField.alpha = 1.0; //username field will now be visible
        self.passwordField.alpha = 1.0; //password will now be visible
        self.loginButton.alpha = 1.0; //login button will now be visible
    } completion:nil];
    //end of animation
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
                //performing ease out animation
                [UIView animateWithDuration:1.5 animations:^{
                    self.usernameField.alpha = 0.0;
                    self.passwordField.alpha = 0.0;
                    self.loginButton.alpha = 0.0;
                } completion:^(BOOL finished) {
                    if (finished == TRUE) {
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                }];
                //Now the user can go to the home page.
                
            }
        }];
    }
}

- (IBAction)openContactUsPage:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://burst.co.in/preview/contact_us.php"]];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];// this will do the trick
}

-(BOOL)prefersStatusBarHidden
{
    return  YES;
}


-(UIImage *)loadRandomImage
{
    NSArray *backgroundImages = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"login-background"],
                                [UIImage imageNamed:@"login-background2"],
                                 [UIImage imageNamed:@"login-background3"],
                                 [UIImage imageNamed:@"login-backgound4"],
                                 [UIImage imageNamed:@"login-background5"],
                                 [UIImage imageNamed:@"login-background6"], nil];
    
    int random = arc4random_uniform((int) backgroundImages.count);
    
    return  [backgroundImages objectAtIndex:random];
}

@end
