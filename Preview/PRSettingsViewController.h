//
//  PRSettingsViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 08/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PRSettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *logout;
- (IBAction)logout:(id)sender;

@end
