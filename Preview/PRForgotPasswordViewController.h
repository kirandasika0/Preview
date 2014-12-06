//
//  PRForgotPasswordViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 20/10/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PRForgotPasswordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UIButton *forgotPassword;
- (IBAction)forgotPassword:(id)sender;
- (IBAction)closeForgotPassword:(id)sender;

@end
