//
//  PRLeaderboardViewCell.h
//  Preview
//
//  Created by SaiKiran Dasika on 22/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PRLeaderboardViewCell : UITableViewCell
+(CGFloat)heightForEntry:(PFObject *)entry;
-(void)configureCellForEntry:(PFUser *)entry;

//IB Outlets
@property (weak, nonatomic) IBOutlet UILabel *usersFullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfReviews;
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;

//All variables
@property (nonatomic, strong) NSString *usersName;


@end
