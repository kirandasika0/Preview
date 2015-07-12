//
//  PRRateGameViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 27/04/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  PRColorWheel;

@interface PRRateGameViewController : UIViewController
//Iboutlets
@property (weak, nonatomic) IBOutlet UIImageView *product1ImageView;
@property (weak, nonatomic) IBOutlet UILabel *product1Label;
@property (weak, nonatomic) IBOutlet UIImageView *product2ImageView;
@property (weak, nonatomic) IBOutlet UILabel *product2Label;
@property (weak, nonatomic) IBOutlet UIView *vView;


//Properties
@property (nonatomic, strong) PRColorWheel *colorWheel;
@property (nonatomic, strong) NSDictionary *returnDictionary;
- (IBAction)playGame:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *playGameButton;

@end
