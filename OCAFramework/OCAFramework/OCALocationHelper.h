//
//  OCALocationHelper.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-5-1.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define OCALocationChangedNotification  @"OCALocationChanged"

@interface OCALocationHelper : NSObject<CLLocationManagerDelegate> {
    CLLocation          *latestLocation;
    CLLocationManager   *locationManager;
    
    NSDate              *startTime;
}

@property (nonatomic, readonly) BOOL    locationServiceDisabled;
@property (nonatomic, readonly) CLLocation      *location;
- (void)start;

- (void)stop;

+ (OCALocationHelper *)sharedInstance;

@end
