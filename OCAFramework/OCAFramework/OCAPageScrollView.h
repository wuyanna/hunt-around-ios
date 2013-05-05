//
//  OCAPageScrollView.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-4-8.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OCAPageScrollViewDelegate;
@interface OCAPageScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic, copy)     NSArray         *pages;
@property (nonatomic, readonly) UIScrollView    *contentView;
@property (nonatomic, readonly) UIPageControl   *pageControl;
@property (nonatomic, assign)   id<OCAPageScrollViewDelegate>   pageScrollDelegate;
@property (nonatomic, assign)   BOOL            hidePageControl;

- (void)scrollToPageAtIndex:(NSUInteger)index animated:(BOOL)animated;
@end


@protocol OCAPageScrollViewDelegate <UIScrollViewDelegate>

- (void)pageScroll:(OCAPageScrollView *)pageScroll didScrollToIndex:(NSInteger)index;

@end