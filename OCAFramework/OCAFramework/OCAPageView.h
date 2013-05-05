//
//  OCAPageView.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-2-22.
//  Copyright (c) 2012年 dianping.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPPictureScrollViewTile : UIView {
    NSUInteger      index;
    
}
@property (nonatomic, assign) NSUInteger index;
@end

@protocol OCAPageViewDataSource;
@interface OCAPageView : UIView <UIScrollViewDelegate> {
    UIScrollView                        *scrollView;
    NSInteger                           centerImageIndex;
	NSInteger                           total;
	NSMutableSet                        *recycledPages;
    NSMutableSet                        *visiblePages;
    id<OCAPageViewDataSource>   dataSource;
}

@property (nonatomic, assign) id<OCAPageViewDataSource>   dataSource;
@property (nonatomic, readonly) NSInteger centerImageIndex;

- (void)reloadData;
- (DPPictureScrollViewTile *)dequeueRecycledTile;
- (void)scrollToTileAtIndex:(NSUInteger)index animated:(BOOL)animated;
@end


@protocol OCAPageViewDataSource <NSObject>
@required
- (DPPictureScrollViewTile *)scrollView:(OCAPageView *)scrollView tileForPageAtIndex:(NSUInteger)index;
@optional
- (NSInteger)numberOfTilesInScrollView:(OCAPageView *)scrollView;
@end