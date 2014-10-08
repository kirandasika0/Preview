//
//  PRFriendsCollectionViewCell.m
//  Preview
//
//  Created by SaiKiran Dasika on 02/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PRFriendsCollectionViewCell.h"

@implementation PRFriendsCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
}


@end
