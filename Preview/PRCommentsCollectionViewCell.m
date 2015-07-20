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
    self.userRatingLabel.text = @"User Rating: .../10";
    NSDate *postedDate = [entry objectForKey:@"sentOn"];
    self.postedTimeAgoLabel.text = [postedDate formattedAsTimeAgo];
    
    [self getUserRatingForProductId:entry.objectId];
}

-(NSString *)getUserRatingForProductId:(NSString *)productId{
    static NSString *userRating = @"";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://burst.co.in/preview/send_star_rating.php?type=for_comment&comment_id=%@", productId]];
    NSLog(@"%@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data.length > 0 && connectionError == nil) {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            userRating = [NSString stringWithFormat:@"User Rating: %@/10", responseDictionary[@"rating"]];
            self.userRatingLabel.text = userRating;
            //NSLog(@"%@", responseDictionary);
            NSLog(@"%@", userRating);
        }
        else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[connectionError.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
        }
    }];
    
    return userRating;
    
}


@end
