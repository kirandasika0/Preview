//
//  PRLeaderboardViewCell.m
//  Preview
//
//  Created by SaiKiran Dasika on 22/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRLeaderboardViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation PRLeaderboardViewCell

+(CGFloat)heightForEntry:(PFObject *)entry {
    const CGFloat topMargin = 35.0f;
    const CGFloat bottomMargin = 90.0f;
    const CGFloat minHeight = 85.0f;
    
    UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    CGRect boundingBox = [[entry objectForKey:@"post_text"] boundingRectWithSize:CGSizeMake(225, CGFLOAT_MAX) options:(NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: font} context:nil];
    
    return  MAX(minHeight, CGRectGetHeight(boundingBox) + topMargin + bottomMargin);
}

-(void)configureCellForEntry:(PFUser *)entry{
    self.usersFullNameLabel.text = [entry objectForKey:@"fullName"];
    self.usernameLabel.text = entry.username;
    PFQuery *query = [PFQuery queryWithClassName:@"comments"];
    [query whereKey:@"user_id" equalTo:entry.objectId];
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"Error.");
        }
        else {
            self.numberOfReviews.text = [NSString stringWithFormat:@"No: of Reviews Given: %d",number];
        }
    }];
    self.profilePictureImageView.image = [UIImage imageNamed:@"tabBarBackground"];
    self.profilePictureImageView.layer.cornerRadius = CGRectGetWidth(self.profilePictureImageView.frame) / 2.0f;
}

@end
