//
//  PREditProfileViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 14/06/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PREditProfileViewController.h"

@interface PREditProfileViewController ()

@end

@implementation PREditProfileViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //We will have to display the navigation bar for the user to navigate back and forth
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (IBAction)saveAction:(id)sender {
}
@end
