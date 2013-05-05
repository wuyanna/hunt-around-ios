//
//  MapLayer.h
//  HuntAround
//
//  Created by yutao on 12-9-7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "RMMapView.h"
#import "MapOverlay.h"

@interface MapController : NSObject<RMMapViewDelegate> {
    RMMapView *mapView;
    
}

@property (nonatomic, retain) UIView *view;
@property (nonatomic, retain) MapOverlay *overlay;
+ (MapController *)sharedInstance;
- (void)loadView;
- (void) setRange:(int) level;
@end
