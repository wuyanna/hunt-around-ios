//
//  MapLayer.m
//  HuntAround
//
//  Created by yutao on 12-9-7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MapController.h"
#import "RMCloudMadeMapSource.h"
#import "RMMarker.h"
#import "RMMarkerManager.h"
#import "PanelController.h"
#import "BuddyController.h"

#define LATLNG_MIN_SETP 0.05

@implementation MapController

+ (MapController *)sharedInstance {
    static MapController *ins = nil;
    if (ins == nil) {
        ins = [[MapController alloc] init];
    }
    return ins;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		_view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
		mapView	= [[RMMapView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)];
        
        // style
        id cmTilesource = [[[RMCloudMadeMapSource alloc] initWithAccessKey:@"8cef9c5f8bb44bfeb15a24453b92ada5" styleNumber:70398] autorelease];
        [[[RMMapContents alloc] initWithView:mapView tilesource: cmTilesource] autorelease];

        // location
        CLLocationCoordinate2D initLocation;
        initLocation.longitude = 121.440676;
        initLocation.latitude  = 31.253776;
        [mapView.contents setMapCenter:initLocation];
        
        // zoom
        [mapView.contents setZoom: 14];
        
        // range
        [self setRange:2];
        
        [mapView setDelegate:self];
        
        // add marker
        [self addMarkerAt:initLocation withText:@"娜娜家"];
        
        NSLog(@"Center: Lat: %lf Lon: %lf", mapView.contents.mapCenter.latitude, mapView.contents.mapCenter.longitude);
	}
	return self;
}


- (void) addMarkerAt: (CLLocationCoordinate2D) markerPosition
{
    [self addMarkerAt:markerPosition withText:nil];
}

- (void) addMarkerAt: (CLLocationCoordinate2D) markerPosition withText: (NSString *) text
{
    UIImage* markerImage = [UIImage imageNamed:@"marker-blue.png"];
    RMMarker* marker = [[RMMarker alloc] initWithUIImage: markerImage anchorPoint: CGPointMake(0.5, 0.5)];
    
    [mapView.markerManager addMarker: marker AtLatLong: markerPosition];
    
    if (text) {
        [self setText:text forMarker: marker];
        marker.label.backgroundColor = [UIColor blueColor];
        //this code shows, how to add your data to marker - simple case - click counter:
        NSNumber* clickCounter = [[NSNumber numberWithInt: 0] autorelease];
        marker.data = clickCounter;
    }
    
    // release the marker as it now retained in mapView.markerManager
    [marker release];
}

- (void) setText: (NSString*) text forMarker: (RMMarker*) marker
{
    CGSize textSize = [text sizeWithFont: [RMMarker defaultFont]];
    
    CGPoint position = CGPointMake(  -(textSize.width/2 - marker.bounds.size.width/2), 0);
    
    [marker changeLabelUsingText: text position: position ];
}


- (void) tapOnMarker: (RMMarker*) marker onMap: (RMMapView*) map
{
    if (_overlay) {
        [_overlay removeFromSuperview];
        _overlay = nil;
    }
    
    CGPoint p = marker.position;
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MapOverlay" owner:self options:nil];
    MapOverlay *lay = [nib objectAtIndex:0];
    CGRect rect = lay.frame;
    rect.origin.x = p.x - (rect.size.width / 2);
    rect.origin.y = p.y - rect.size.height;
    lay.frame = rect;
    lay.title.text = @"娜娜的家";
    [mapView addSubview:lay];
    
//    NSInteger clickCounter = [((NSNumber*) marker.data) intValue] + 1;
//    marker.data = [NSNumber numberWithInt: clickCounter ];
//    NSString* markerText = [NSString stringWithFormat:@"tapped %d times", clickCounter];
//    [self setText: markerText forMarker: marker];
}

- (void) singleTapOnMap: (RMMapView*) map At: (CGPoint) point {
//    if (_overlay) {
//        [_overlay removeFromSuperview];
//        _overlay = nil;
//    }
}

- (void) afterMapMove: (RMMapView*) map
{
    
}


- (void)addLabel {

}

- (void)addOverlayAt
{

}


- (void)loadView {
    [_view addSubview:mapView];
    [[[[CCDirector sharedDirector] view] superview] insertSubview:_view atIndex:0];
}

- (void) setRange:(int) level {
    CLLocationCoordinate2D mapCenter = [[mapView contents] mapCenter];
    CLLocationCoordinate2D sw;
    sw.latitude = mapCenter.latitude - (level * LATLNG_MIN_SETP);
    sw.longitude = mapCenter.longitude - (level * LATLNG_MIN_SETP);
    
    CLLocationCoordinate2D ne;
    ne.latitude = mapCenter.latitude + (level * LATLNG_MIN_SETP);
    ne.longitude = mapCenter.longitude + (level * LATLNG_MIN_SETP);
//    CLLocationCoordinate2D sw;
//    sw.latitude = -33.9855;
//    sw.longitude = 151.167;
//    
//    CLLocationCoordinate2D ne;
//    ne.latitude = -33.9129;
//    ne.longitude = 151.255;
    [mapView setConstraintsSW:sw NE:ne];
    
    //        RMProjectedPoint pointSW;
    //        pointSW.easting = 50000;
    //        pointSW.northing = 50000;
    //
    //        RMProjectedPoint pointNE;
    //        pointNE.easting = -50000;
    //        pointNE.northing = -50000;
    //        [mapView setProjectedContraintsSW:pointSW NE:pointNE];
}

- (void)showPanel {
    [[PanelController sharedInstance] showPanel];

}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
    // cleanup
    
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
