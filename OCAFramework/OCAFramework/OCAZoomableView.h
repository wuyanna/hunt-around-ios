//
//  OCAZoomableView.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-5-2.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCAZoomableView : UIScrollView <UIScrollViewDelegate> {

}

@property (nonatomic, assign) BOOL  zoomEnabled;
@property (nonatomic, retain) UIView  *zoomableView;
@end
