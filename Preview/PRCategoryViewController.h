//
//  PRCategoryViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 10/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StartApp/StartApp.h>
#import <StartApp/STABannerView.h>
#import <StartApp/STABannerSize.h>

@interface PRCategoryViewController : UITableViewController
{
    STABannerView* bannerView;
}

@property (nonatomic,strong) NSMutableArray *categoryPost;

@end
