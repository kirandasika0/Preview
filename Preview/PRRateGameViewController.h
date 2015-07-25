//
//  PRRateGameViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 27/04/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRProductA.h"
#import "PRProductB.h"

@class  PRColorWheel;

@interface PRRateGameViewController : UIViewController
//Iboutlets
@property (nonatomic, weak) IBOutlet UIView *productAView;
@property (nonatomic, weak) IBOutlet UIView *productBView;
@property (nonatomic, weak) IBOutlet UIImageView *productAImageView;
@property (nonatomic, weak) IBOutlet UIImageView *productBImageView;
@property (weak, nonatomic) IBOutlet UIView *vView;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productBNameLabel;


//Properties
@property (nonatomic, strong) PRColorWheel *colorWheel;
@property (nonatomic, strong) NSDictionary *returnDictionary;
- (IBAction)playGame:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *playGameButton;
@property (strong, nonatomic) NSDictionary *productAInformation;
@property (strong, nonatomic) NSDictionary *productBInformation;
@property (strong, nonatomic) PRProductA *sampleProductAInstance;

@end
