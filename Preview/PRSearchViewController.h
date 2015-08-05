//
//  PRSearchViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 31/07/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRSearchViewController : UITableViewController<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *previewSearchBar;
@property (weak, nonatomic) NSString *searchString;
@property (nonatomic, strong) NSMutableArray *resultsArray;
@property (nonatomic, strong) NSDictionary *selectedProduct;
@end
