//
//  PRCommentsCollectionViewCell.m
//  Preview
//
//  Created by SaiKiran Dasika on 04/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRCommentsCollectionViewCell.h"
#import "NSDate+NVTimeAgo.h"

@implementation PRCommentsCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(CGFloat)heightForEntry:(PFObject *)entry {
    const CGFloat topMargin = 35.0f;
    const CGFloat bottomMargin = 90.0f;
    const CGFloat minHeight = 85.0f;
    
    UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    CGRect boundingBox = [[entry objectForKey:@"comment"] boundingRectWithSize:CGSizeMake(225, CGFLOAT_MAX) options:(NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: font} context:nil];
    
    return  MAX(minHeight, CGRectGetHeight(boundingBox) + topMargin + bottomMargin);
}

-(void)configureCellForEntry:(PFObject *)entry{
    self.usersNameLabel.text = [entry objectForKey:@"fullName"];
    self.commentTextView.text = [entry objectForKey:@"comment"];
    NSDate *postedDate = [entry objectForKey:@"sentOn"];
    self.postedTimeAgoLabel.text = [postedDate formattedAsTimeAgo];
}


@end
