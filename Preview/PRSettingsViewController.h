//
//  PRSettingsViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 21/07/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRSettingsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *appraisalImageView;

@property (weak, nonatomic) IBOutlet UITableView *settingsTableView;


#pragma mark - Properties
@property (nonatomic, strong) NSArray *settingsTitles;
@property (nonatomic, strong) NSURL *detailSettingURL;

@end
