//
//  PRUserLocation.h
//  Preview
//
//  Created by SaiKiran Dasika on 06/12/14.
//  Copyright (c) 2014 Burst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRUserLocation : NSObject

@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *postalCode;
@property (strong, nonatomic) NSString *timeZone;
@property (strong, nonatomic) NSString *regionCode;
@property (strong, nonatomic) NSString *countryCode;
@property (strong, nonatomic) NSString *asn;

@end
