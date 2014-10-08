//
//  PRcommentsCollectionViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 04/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <Parse/Parse.h>

@interface PRcommentsCollectionViewController : UICollectionViewController

@property (strong, nonatomic) NSArray *comments;
@property (strong, nonatomic) NSString *productUniqueID;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end
