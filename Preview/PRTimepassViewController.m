//
//  PRTimepassViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 24/03/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import "PRTimepassViewController.h"

@interface PRTimepassViewController ()

@end

@implementation PRTimepassViewController{
    UIDynamicAnimator *_animator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.redSquare]];
    
    [_animator addBehavior:gravity];
    
    //Collision
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.redSquare,self.blueSquare]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    [_animator addBehavior:collision];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
