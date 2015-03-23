//
//  PRNearbyViewController.h
//  Preview
//
//  Created by SaiKiran Dasika on 24/01/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface PRNearbyViewController : UIViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
- (IBAction)goBack:(id)sender;

@end
