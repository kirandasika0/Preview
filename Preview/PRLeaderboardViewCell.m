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
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query whereKey:@"user_id" equalTo:entry.objectId];
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"Error.");
        }
        else {
            self.numberOfReviews.text = [NSString stringWithFormat:@"No: of Reviews Given: %d",number];
        }
    }];
    PFFile *file = [entry objectForKey:@"pro_pic"];
    NSURL *url = [NSURL URLWithString:file.url];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        if (imageData != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *image = [UIImage imageWithData:imageData];
                self.profilePictureImageView.image = image;
            });
        }
        else{
            self.profilePictureImageView.image = [UIImage imageNamed:@"default-avatar"];
        }
    });
    self.profilePictureImageView.layer.cornerRadius = CGRectGetWidth(self.profilePictureImageView.frame) / 2.0f;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.y += 4;
    frame.size.height -= 2 * 4;
    [super setFrame:frame];
}
@end
