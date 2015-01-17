//
//  PRFeedPost.h
//  Preview
//
//  Created by SaiKiran Dasika on 10/05/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRFeedPost : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *category;
@property (nonatomic,strong) NSString *originalImage;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic,strong) NSString *decp;
@property (nonatomic,strong) NSString *rating;
@property (nonatomic,strong) NSString *uniqueID;
@property (nonatomic, strong) NSString *userCity;
@property (nonatomic, strong) NSString *userCountry;


- (id) initWithTitle:(NSString *)title;
+ (id) blogPostWithTitle:(NSString *)title;


- (NSURL *) thumbnailURL;

#pragma mark - Properties for the Related Pictures

@property (nonatomic,strong) NSString *relatedPictureOriginal;
@property (nonatomic,strong) NSString *relatedPictureThumbnail;

@end
