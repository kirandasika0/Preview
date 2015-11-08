//
//  PRProductGalleryViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 06/09/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import "PRProductGalleryViewController.h"
#import "AFNetworking.h"

@interface PRProductGalleryViewController ()

@end

int imageIndex = 0;

@implementation PRProductGalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"id": self.productId};
    [manager POST:@"https://preview-backend.herokuapp.com/backend/get_related_pics/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%@", responseObject);
        //set the title of the nav bar
        self.imageLinks = responseObject[@"response"];
        NSString *primaryNavBarString = [NSString stringWithFormat:@"1 of %ld", [self.imageLinks count] -1];
        self.picCounterLabel.text = primaryNavBarString;
        self.navBar.topItem.title = primaryNavBarString;
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        //We have to load the first image so that the user can swipe through the rest
        
        NSURL *firstImageURL = [NSURL URLWithString:self.imageLinks[0]];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            NSData *firstImageData = [NSData dataWithContentsOfURL:firstImageURL];
            if (firstImageData != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage *firstImage = [UIImage imageWithData:firstImageData];
                    self.picImageView.image = firstImage;
                });
            }
        });
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Looks like there was a problem with the network");
        NSLog(@"%@", error);
        [self dismissViewControllerAnimated:YES completion:nil];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
    
    
    
}




-(BOOL)prefersStatusBarHidden{
    return YES;
}
- (IBAction)handleSwipe:(UISwipeGestureRecognizer *)sender {
    UISwipeGestureRecognizerDirection direction = [(UISwipeGestureRecognizer *) sender direction];
    
    //checking which direction the user has swiped.
    switch (direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            if (imageIndex <= (self.imageLinks.count - 1)) {
                imageIndex++;
            }
            break;
            
        case UISwipeGestureRecognizerDirectionRight:
            if (imageIndex != 0) {
                imageIndex--;
            }
            break;
            
        default:
            break;
    }
    
    //main logic for opening the gallery.
    
    NSLog(@"%d", imageIndex);
    
    NSString *secondryNavBarString = [NSString stringWithFormat:@"%d of %ld", imageIndex + 1, self.imageLinks.count - 1];
    //setting the navigation bar and the label below with the required information.
    self.picCounterLabel.text = secondryNavBarString;
    self.navBar.topItem.title = secondryNavBarString;
    
    
    NSURL *imageURL = [NSURL URLWithString:self.imageLinks[imageIndex]];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        if (imageData != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *relatedImage = [UIImage imageWithData:imageData];
                self.picImageView.image = relatedImage;
            });
        }
    });
    
    
    
}

- (IBAction)closeView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
