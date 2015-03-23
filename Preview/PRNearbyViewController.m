//
//  PRNearbyViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 24/01/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import "PRNearbyViewController.h"
#import <Parse/Parse.h>

@interface PRNearbyViewController ()
@end

@implementation PRNearbyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myMapView.delegate = self;
    self.myMapView.mapType = MKMapTypeStandard;
    [self.myMapView setShowsUserLocation:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    //Coordinates of the user
    CLLocationCoordinate2D myLocation = [userLocation coordinate];
    
    //Define zoom region
    MKCoordinateRegion zoomRegion = MKCoordinateRegionMakeWithDistance(myLocation, 2500, 2500);
    
    //show user location
    [self.myMapView setRegion:zoomRegion animated:YES];
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (IBAction)goBack:(id)sender {
    [self.tabBarController setSelectedIndex:0];
}
@end
