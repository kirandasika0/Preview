//
//  PRSelectedCategoryViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 11/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface PRSelectedCategoryViewController : UITableViewController

@property (nonatomic,strong) NSString *emitterFileURL;
@property (nonatomic,strong) NSMutableArray *feedPost;
@property (strong, nonatomic) NSArray *productsArray;



@end
