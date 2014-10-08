//
//  PRCommentsCollectionViewCell.h
//  Preview
//
//  Created by SaiKiran Dasika on 04/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PRCommentsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *usersNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UILabel *postedTimeAgoLabel;

+(CGFloat)heightForEntry:(PFObject *)entry;
-(void)configureCellForEntry:(PFObject *)entry;

@end
