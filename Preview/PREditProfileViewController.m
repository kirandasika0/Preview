//
//  PREditProfileViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 14/06/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import "PREditProfileViewController.h"
#import <Parse/Parse.h>

@interface PREditProfileViewController ()

@end

@implementation PREditProfileViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //We will have to display the navigation bar for the user to navigate back and forth
    if (self.image == nil) {
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.allowsEditing = NO;
        self.imagePicker.videoMaximumDuration = 0;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else {
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
        self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
        
        
        [self presentViewController: self.imagePicker animated:NO completion:nil];
    }


}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.tabBarController setSelectedIndex:2];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        UIImage *pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        self.imageView.image = pickedImage;
        
        self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        self.CIImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            //save image !
            UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, nil);
        }
}

- (IBAction)setAsDPButton:(id)sender {
    NSData *fileData;
    NSString *fileName;
    NSString *fileType;
    if (self.image !=nil) {
        UIImage *newImage = self.image;
        fileData = UIImagePNGRepresentation(newImage);
        fileName = @"pro_pic.png";
        fileType = @"image";
    }
    PFFile *file = [PFFile fileWithName:fileName data:fileData];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(error){
            
        }
        else{
            PFQuery *query = [PFUser query];
            [query getObjectInBackgroundWithId:[[PFUser currentUser] objectId] block:^(PFObject *object, NSError *error) {
                //let's update
                object[@"pro_pic"] = file;
                object[@"type"] = fileType;
                [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (error) {
                        //error
                    }
                    else{
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }
                }];
            }];
        }
    } progressBlock:^(int percentDone) {
        [self.progressBar setProgress:(percentDone / 100.0)];
    }];
}
- (IBAction)setAsCoverImageButton:(id)sender {
    NSData *fileData;
    NSString *fileName;
    NSString *fileType;
    if (self.image !=nil) {
        UIImage *newImage = self.image;
        fileData = UIImagePNGRepresentation(newImage);
        fileName = @"cover_pic.png";
        fileType = @"image";
    }
    PFFile *file = [PFFile fileWithName:fileName data:fileData];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"Error uploading your cover picture");
        }
        else{
            PFQuery *query = [PFUser query];
            [query getObjectInBackgroundWithId:[[PFUser currentUser] objectId] block:^(PFObject *object, NSError *error) {
                if (error) {
                    NSLog(@"Error Entering into the database.");
                }
                else{
                    //Update the cover pic to the user's table
                    object[@"cover_pic"] = file;
                    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if (error) {
                            //error
                        }
                        else{
                            [self dismissViewControllerAnimated:YES completion:nil];
                        }
                    }];
                }
            }];
        }
        
    } progressBlock:^(int percentDone) {
        [self.progressBar setProgress:(percentDone / 100.0)];
    }];
}
//turning status bar off
-(BOOL)prefersStatusBarHidden{
    return NO;
}
- (IBAction)cancelButton:(id)sender {
    self.image = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
