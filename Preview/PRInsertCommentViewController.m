//
//  PRInsertCommentViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 04/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRInsertCommentViewController.h"

@interface PRInsertCommentViewController ()

@end

@implementation PRInsertCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentUser = [PFUser currentUser];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UITapGestureRecognizer *closeInsertPost = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeViewController)];
    closeInsertPost.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:closeInsertPost];
}


- (IBAction)insertComment:(id)sender {
    NSString *comment = [self.commentTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([comment length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Looks like you have'nt typed anything in the comment text box." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else {
        PFObject *currentComment = [PFObject objectWithClassName:@"comments"];
        currentComment[@"product_id"] = self.productUniqueID;
        currentComment[@"user_id"] = self.currentUser.objectId;
        currentComment[@"username"] = self.currentUser.username;
        currentComment[@"fullName"] = [self.currentUser objectForKey:@"fullName"];
        currentComment[@"comment"] = comment;
        NSDate *todaysDate = [[NSDate alloc] init];
        currentComment[@"sentOn"] = todaysDate;
        [currentComment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                NSLog(@"Error.");
            }
            else {
                //[self dismissViewControllerAnimated:YES completion:nil];
                NSLog(@"Uploaded.");
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    }
}
-(void)closeViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
