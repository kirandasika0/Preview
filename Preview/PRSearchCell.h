//
//  PRSearchCell.h
//  Preview
//
//  Created by SaiKiran Dasika on 01/08/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRSearchCell : UITableViewCell
-(void)configureCellForProduct:(NSDictionary *)product;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;

@end
