//
//  DPPictureScrollView.m
//  DPScope
//
//  Created by Wu Yanna on 12-2-22.
//  Copyright (c) 2012年 dianping.com. All rights reserved.
//

#import "OCAPageView.h"

@implementation DPPictureScrollViewTile

@synthesize index;

@end

@interface OCAPageView (Private)
- (void)tilePages;
- (CGRect)frameForPagingScrollView;
- (CGRect)frameForPageAtIndex:(NSUInteger)index;
- (BOOL)isDisplayingPageForIndex:(NSUInteger)index;
- (void)configurePage:(DPPictureScrollViewTile *)page forIndex:(NSUInteger)idx;
@end;

@implementation OCAPageView

@synthesize dataSource;
@synthesize centerImageIndex;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];
        scrollView.clipsToBounds = NO;		// default is NO, we want to restrict drawing within our scrollview
        scrollView.scrollEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        //scrollView.scrollsToTop = YES; 无效
        // pagingEnabled property default is NO, if set the scroller will stop or snap at each photo
        // if you want free-flowing scroll, don't set this property.
        scrollView.pagingEnabled = YES;
        scrollView.bounces = YES;
        scrollView.directionalLockEnabled = YES;
        scrollView.delegate = self;
        recycledPages = [[NSMutableSet alloc] init];
        visiblePages  = [[NSMutableSet alloc] init];
        [self addSubview:scrollView];
    }
    return self;
}

- (void)reloadData {
    total = [dataSource numberOfTilesInScrollView:self];
	scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.frame) * total, CGRectGetHeight(scrollView.frame));
    if ([visiblePages count]>0) {
        for (DPPictureScrollViewTile *page in visiblePages) {
            [page removeFromSuperview];
        }
        [visiblePages removeAllObjects];
        
    }
    if (total > 0) {
        [self tilePages];
    }
    
}

- (void)tilePages 
{
	// Calculate which pages are visible
	CGRect visibleBounds = scrollView.bounds;
	NSInteger pageNo = roundf(CGRectGetMinX(visibleBounds) / CGRectGetWidth(visibleBounds));
	int firstNeededPageIndex = MAX(pageNo - 1, 0);
	int lastNeededPageIndex = MIN(pageNo + 1, total-1);
	
	// Recycle no-longer-visible pages 
	for (DPPictureScrollViewTile *page in visiblePages) {
		if (page.index < firstNeededPageIndex || page.index > lastNeededPageIndex) {
			[recycledPages addObject:page];
			[page removeFromSuperview];
		}
	}
	[visiblePages minusSet:recycledPages];
	
	NSArray *pageQueue = [NSArray arrayWithObjects:[NSNumber numberWithInt:pageNo], [NSNumber numberWithInt:lastNeededPageIndex], [NSNumber numberWithInt:firstNeededPageIndex], nil];
	for (NSNumber* eachPageIndex in pageQueue) {
		int index = [eachPageIndex intValue];
		if (![self isDisplayingPageForIndex:index]) {
			// add missing pages
			DPPictureScrollViewTile *page = [dataSource scrollView:self tileForPageAtIndex:index];
            [self configurePage:page forIndex:index];
			[scrollView addSubview:page];
			[visiblePages addObject:page];
		}
	}
}

- (DPPictureScrollViewTile *)dequeueRecycledTile
{
    DPPictureScrollViewTile *page = [recycledPages anyObject];
    if (page) {
        [[page retain] autorelease];
        [recycledPages removeObject:page];
    }
    return page;
}

- (BOOL)isDisplayingPageForIndex:(NSUInteger)index
{
    BOOL foundPage = NO;
    for (DPPictureScrollViewTile *page in visiblePages) {
        if (page.index == index) {
            foundPage = YES;
            break;
        }
    }
    return foundPage;
}

- (void)configurePage:(DPPictureScrollViewTile *)page forIndex:(NSUInteger)idx
{
	page.index = idx;
    page.frame = [self frameForPageAtIndex:idx];
}

- (CGRect)frameForPagingScrollView {
    //CGRect frame = [[UIScreen mainScreen] bounds];
	CGRect frame = CGRectMake(0, 0, CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame));
    return frame;
	
}

- (CGRect)frameForPageAtIndex:(NSUInteger)index {
    CGRect pagingScrollViewFrame = [self frameForPagingScrollView];
    
    CGRect pageFrame = pagingScrollViewFrame;
    pageFrame.origin.x = pagingScrollViewFrame.size.width * index;
    return pageFrame;
}

- (void)scrollToTileAtIndex:(NSUInteger)index animated:(BOOL)animated{
    CGFloat offsetX = (CGFloat)index * [self frameForPagingScrollView].size.width;
    [scrollView setContentOffset:CGPointMake(offsetX, 0.0) animated:animated];
    centerImageIndex = index;
}

#pragma scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)sView
{
	[self tilePages];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sView
{
	CGRect visibleBounds = sView.bounds;
    NSInteger page = roundf(CGRectGetMinX(visibleBounds) / CGRectGetWidth(visibleBounds));
	
	if (centerImageIndex != page) 
	{
		centerImageIndex = page;
	}
}

- (void)dealloc {
    [super dealloc];
    [scrollView removeFromSuperview];
    [scrollView release];
    [recycledPages release];
    [visiblePages release];
}

@end
