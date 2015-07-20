//
//  PRLoginViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 10/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIImageView *backgoundImageView;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;


- (IBAction)login:(id)sender;
- (IBAction)openContactUsPage:(id)sender;

@end
