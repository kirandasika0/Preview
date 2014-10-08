//
//  PRSuggestCategoryViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 11/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PRSuggestCategoryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *suggestCategoryField;
- (IBAction)suggestCategory:(id)sender;

@end
