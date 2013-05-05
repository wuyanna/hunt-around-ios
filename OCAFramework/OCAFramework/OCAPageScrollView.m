//
//  OCAPageScrollView.m
//  OCAFramework
//
//  Created by Wu Yanna on 12-4-8.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import "OCAPageScrollView.h"

#define DEFAULT_PAGECONTROL_HEIGHT      36

@interface OCAPageScrollView (Private)

- (void)layoutScrollViews;
- (void)loadScrollView;
- (void)initialize;
@end

@implementation OCAPageScrollView

@synthesize pages = _pages;
@synthesize pageControl = _pageControl;
@synthesize contentView = _contentView;
@synthesize pageScrollDelegate = _pageScrollDelegate;
@synthesize hidePageControl = _hidePageControl;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib {
    [self initialize];
}

- (void)initialize {
    _contentView = [[UIScrollView alloc] initWithFrame:self.bounds];
//    _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin;
    [_contentView autoresizesSubviews];
    _contentView.pagingEnabled = YES;
    _contentView.delegate  = self;
    _contentView.directionalLockEnabled = YES;
    _contentView.showsVerticalScrollIndicator = NO;
    _contentView.showsHorizontalScrollIndicator = NO;
    _contentView.alwaysBounceVertical = NO;
    [self addSubview:_contentView];
    
    CGFloat pY = self.frame.size.height - DEFAULT_PAGECONTROL_HEIGHT;
    CGRect pFrame = CGRectMake(self.bounds.origin.x, pY, self.bounds.size.width, DEFAULT_PAGECONTROL_HEIGHT);
    _pageControl = [[UIPageControl alloc] initWithFrame:pFrame];
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    _pageControl.hidesForSinglePage = NO;
    [self addSubview:_pageControl];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setPages:(NSArray *)pages {
    if (_pages != pages) {
        [_pages release];
        _pages = [pages retain];
        
        [self loadScrollView];
    }
}

- (void)setHidePageControl:(BOOL)hidePageControl {
    _pageControl.hidden = hidePageControl;
}

- (void)loadScrollView {
    _contentView.frame = self.bounds;
    for (UIView *subview in _contentView.subviews) {
        [subview removeFromSuperview];
    }
    for (int i = 0; i < [_pages count]; i++) {
        UIView *pageView = [_pages objectAtIndex:i];
        // 检查_pages数组中内容时候合法
        if ([pageView isKindOfClass:[UIView class]]) {
            [self.contentView addSubview:pageView];
        } else {
            return;
        }
    }
    [self layoutScrollViews];
    _pageControl.numberOfPages = [_pages count];
}

- (void)layoutScrollViews
{
	UIView *view = nil;
	NSArray *subviews = [self.contentView subviews];
    
	// reposition all image subviews in a horizontal serial fashion
	CGFloat curXLoc = 0;
	for (view in subviews)
	{
		if ([view isKindOfClass:[UIView class]])
		{
			CGRect frame = view.frame;
			frame.origin = CGPointMake(curXLoc, 0);
			view.frame = frame;
            
			curXLoc += self.frame.size.width;            
		}
	}
	// set the content size so it can be scrollable
	[self.contentView setContentSize:CGSizeMake(self.frame.size.width * [_pages count], self.frame.size.height)];
}

- (void)scrollToPageAtIndex:(NSUInteger)index animated:(BOOL)animated{
    CGFloat offsetX = (CGFloat)index * self.contentView.bounds.size.width;
    [_contentView setContentOffset:CGPointMake(offsetX, 0.0) animated:animated];
}

#pragma scrollview delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)sView {
    if (sView == _contentView) {
        NSInteger page = ((UIScrollView *)sView).contentOffset.x / self.bounds.size.width;
        
        if (page == _pageControl.currentPage) {
            return;
        }
        _pageControl.currentPage = page;
        
        if (_pageScrollDelegate && [_pageScrollDelegate respondsToSelector:@selector(pageScroll:didScrollToIndex:)]) {
            [_pageScrollDelegate pageScroll:self didScrollToIndex:page];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _contentView) {
        if (_pageScrollDelegate && [_pageScrollDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
            [_pageScrollDelegate scrollViewDidScroll:scrollView];
        }
    }
    
}

- (IBAction)changePage:(id)sender {
    int page = _pageControl.currentPage;
    [_contentView scrollRectToVisible:CGRectMake(self.bounds.size.width * page, 0, self.bounds.size.width, self.bounds.size.height) animated:YES];
}

- (void)dealloc {
    NSLog(@"contentView retain count:%d",[_contentView retainCount]);
    [_contentView release];
    NSLog(@"contentView retain count after release:%d",[_contentView retainCount]);
    _contentView = nil; // 不置nil就会crash 野指针（scrollViewdelegate）
    NSLog(@"pageControl retain count:%d",[_pageControl retainCount]);
    [_pageControl release];
    NSLog(@"pageControl retain count after release:%d",[_pageControl retainCount]);
    NSLog(@"pages retain count :%d",[_pages retainCount]);
    self.pages = nil;
    [super dealloc];
}

@end
