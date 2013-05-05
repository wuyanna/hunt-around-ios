//
//  OCALocation.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-4-16.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface OCALocation : NSObject //<NSCoding, NSCopying>

@property (readonly, nonatomic) CLLocationCoordinate2D  coordinate;
@property (readonly, nonatomic) CLLocationAccuracy      accuracy;

@end
