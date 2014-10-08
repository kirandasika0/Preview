//
//  PRProfileViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 08/06/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRProfileViewController.h"
#import <Parse/Parse.h>

@interface PRProfileViewController ()

@end

@implementation PRProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Hiding the navigation bar.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
   //Setting the image view with the profile picture.
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"%@",currentUser);
    NSURL *imageURL = [NSURL URLWithString:@"https://lh4.ggpht.com/vdK_CsMSsJoYvJpYgaj91fiJ1T8rnSHHbXL0Em378kQaaf_BGyvUek2aU9z2qbxJCAFV=w300"];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *profilePictureImage = [UIImage imageWithData:imageData];
    self.profilePicImageView.image = profilePictureImage;
    
    //Setting the username label property
    self.usernameLabel.text = [currentUser objectForKey:@"fullName"];
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveTableft)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipe];
    //Setting up the right swipe
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveTabRight)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //Setting the tab bar controller
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)moveTableft {
    //[self.tabBarController setSelectedIndex:2];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.scrollerView layoutIfNeeded];
    self.scrollerView.contentSize = self.contentView.bounds.size;
}
-(void)moveTabRight {
    [self.tabBarController setSelectedIndex:0];
}


@end
