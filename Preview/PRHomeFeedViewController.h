//
//  PRHomeFeedViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 10/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PRHomeFeedViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray *feedPosts;


- (IBAction)logout:(id)sender;


@end
