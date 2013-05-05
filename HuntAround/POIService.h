//
//  POIService.h
//  HuntAround
//
//  Created by yanna on 12-12-19.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface POIService : NSObject

- (void)updatePOIListWithLat:(CLLocationDegrees)lat lng:(CLLocationDegrees)lng range:(NSInteger)range;

@end
