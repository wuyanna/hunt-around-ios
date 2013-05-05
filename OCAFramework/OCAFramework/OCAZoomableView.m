//
//  OCAZoomableView.m
//  OCAFramework
//
//  Created by Wu Yanna on 12-5-2.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import "OCAZoomableView.h"

@implementation OCAZoomableView
@synthesize zoomEnabled = _zoomEnabled;
@synthesize zoomableView = _zoomableView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bouncesZoom = YES;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.delegate = self;
    }
    return self;
}

- (void)setZoomEnabled:(BOOL)zoomEnabled {
    _zoomEnabled = zoomEnabled;
    if (!_zoomEnabled) {
		self.zoomScale = 1.0;
		self.maximumZoomScale = 1.0;
		self.minimumZoomScale = 1.0;
		self.contentSize = CGSizeZero;
	} else {
		self.maximumZoomScale = 3.0;
		self.minimumZoomScale = 1.0;
	}
}

- (void)layoutSubviews 
{
    [super layoutSubviews];
    
    // center the image as it becomes smaller than the size of the screen
    
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = _zoomableView.frame;
    
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width)
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    else
        frameToCenter.origin.x = 0;
    
    // center vertically
    if (frameToCenter.size.height < boundsSize.height)
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    else
        frameToCenter.origin.y = 0;
    
    _zoomableView.frame = frameToCenter;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark -
#pragma mark UIScrollView delegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _zoomableView;
}

@end
