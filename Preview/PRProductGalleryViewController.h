//
//  PRProductGalleryViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 06/09/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRProductGalleryViewController : UIViewController

@property (nonatomic, strong) NSString *productId;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (strong, nonatomic) NSArray *imageLinks;

- (IBAction)handleSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)closeView:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UILabel *picCounterLabel;

@end
