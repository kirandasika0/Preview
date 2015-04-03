//
//  PRRelatedViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 29/03/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@interface PRRelatedViewController : UICollectionViewController

@property (nonatomic,strong) NSArray *seenProducts;
@property (nonatomic,strong) NSArray *mostFrequentArray;

@end
