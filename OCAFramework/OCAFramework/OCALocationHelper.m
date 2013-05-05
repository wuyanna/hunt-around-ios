//
//  OCALocationHelper.m
//  OCAFramework
//
//  Created by Wu Yanna on 12-5-1.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import "OCALocationHelper.h"

@implementation OCALocationHelper

@synthesize locationServiceDisabled;
@synthesize location;
+ (OCALocationHelper *)sharedInstance {
	static OCALocationHelper *instance = nil;
	if(instance == nil) {
		instance = [[OCALocationHelper alloc] init];
	}
	return instance;
}

- (id)init {
	if(self = [super init]) {

		locationManager = [[CLLocationManager alloc] init];
		NSInteger locateAccuracy = [[NSUserDefaults standardUserDefaults] integerForKey:@"configLocateAccuracy"];
		switch (locateAccuracy) {
			case 1:
				locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
				break;
			case 2:
				locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
				break;
			case 3:
				locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
				break;
			case 4:
				locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
				break;
			default:
				locationManager.desiredAccuracy = kCLLocationAccuracyBest;
				break;
		}
        
		[locationManager setDelegate:self];
	}
	return self;
}

- (void)start {
    
    [startTime release];
	startTime = [[NSDate alloc] init];
    [locationManager startUpdatingLocation];
	
//	[[NSNotificationCenter defaultCenter] postNotificationName:OCALocationChangedNotification object:self];
}

- (void)stop {
    [startTime release];
	startTime = nil;
    [locationManager stopUpdatingLocation];
}

- (CLLocation *)location {
    return [locationManager location];
}
/*
 * We want to get and store a location measurement that meets the desired accuracy. For this example, we are
 *      going to use horizontal accuracy as the deciding factor. In other cases, you may wish to use vertical
 *      accuracy, or both together.
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // The location "unknown" error simply means the manager is currently unable to get the location.
    // We can ignore this error for the scenario of getting a single location fix, because we already have a 
    // timeout that will stop the location manager to save power.
    if ([error code] != kCLErrorLocationUnknown) {
        [locationManager stopUpdatingLocation];
    }
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[startTime release];
	[locationManager stopUpdatingLocation];
	[locationManager release];
	[latestLocation release];
	[super dealloc];
}

@end
