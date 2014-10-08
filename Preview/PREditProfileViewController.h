//
//  PREditProfileViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 14/06/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PREditProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *bioTextView;
- (IBAction)saveAction:(id)sender;

@end
