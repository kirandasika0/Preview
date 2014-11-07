//
//  PRInsertCommentViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 04/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PRInsertCommentViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (strong, nonatomic) PFUser *currentUser;
@property (strong, nonatomic) NSString *productUniqueID;

- (IBAction)insertComment:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *ratingTableView;
@property (strong, nonatomic) NSMutableArray *ratingParas;

@end
