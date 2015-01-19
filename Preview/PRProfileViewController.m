//
//  PRProfileViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 08/06/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRProfileViewController.h"
#import <Parse/Parse.h>
#import "SAMCache.h"

@interface PRProfileViewController ()

@end

@implementation PRProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //Setting the tab bar controller
    //Setting up the profile page.
    PFUser *currentUser = [PFUser currentUser];
    //Setting the user full name on  the usernamelabel
    self.userFullNameLabel.text = currentUser[@"fullName"];
    self.userFullNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.userFullNameLabel.numberOfLines = 0;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://burst.co.in/preview/web"]];
    [self.displaySeenProductsWebView loadRequest: request];
    //load the profile picture
    //query the database to get the picture
    PFQuery *queryForPic = [PFUser query];
    [queryForPic whereKey:@"objectId" equalTo:currentUser.objectId];
    [queryForPic findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Problem with the query.");
        }
        else{
            for(PFObject *profilePictureObject in objects)
            {
                //Setting the profile picture
                PFFile *file = [profilePictureObject objectForKey:@"pro_pic"];
                NSURL *url = [NSURL URLWithString:file.url];
                NSData *imageData = [NSData dataWithContentsOfURL:url];
                UIImage *image = [UIImage imageWithData:imageData];
                self.profilePictureImageView.image = image;
                self.profilePictureImageView.layer.cornerRadius = CGRectGetWidth(self.profilePictureImageView.frame) / 2.0f;
                //Setting the cover picture
                PFFile *coverPictureFile = [profilePictureObject objectForKey:@"cover_pic"];
                NSURL *urlForCoverPic = [NSURL URLWithString:coverPictureFile.url];
                NSData *coverPictureData = [NSData dataWithContentsOfURL:urlForCoverPic];
                UIImage *coverImage = [UIImage imageWithData:coverPictureData];
                self.coverImageView.image = coverImage;
            }
        }
    }];
    
}

#pragma mark - Change Full Name to Username
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    PFUser *currentUser = [PFUser currentUser];
    self.userFullNameLabel.text = currentUser.username;
    self.userFullNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.userFullNameLabel.numberOfLines = 0;
}

#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showEditProfile"]) {
        [self.tabBarController setHidesBottomBarWhenPushed:YES];
    }
}

@end
