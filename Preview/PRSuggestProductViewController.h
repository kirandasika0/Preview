//
//  PRSuggestProductViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 11/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PRSuggestProductViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *suggestProductField;

- (IBAction)suggestProduct:(id)sender;

@end
