//
//  PRFriendsCollectionViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 02/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PRFriendsCollectionViewController : UICollectionViewController

@property (strong, nonatomic) NSArray *allUsers;
@property (strong, nonatomic) NSString *numberOfUsers;
@end
