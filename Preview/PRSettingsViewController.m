//
//  PRSettingsViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 08/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRSettingsViewController.h"

@interface PRSettingsViewController ()

@end

@implementation PRSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (IBAction)logout:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showLoginFromSettings" sender:nil];
}
@end
