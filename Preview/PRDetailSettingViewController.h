//
//  PRDetailSettingViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 21/07/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRDetailSettingViewController : UIViewController
@property (nonatomic, strong) NSURL *detailSettingURL;
@property (weak, nonatomic) IBOutlet UIWebView *settingWebView;

@end
