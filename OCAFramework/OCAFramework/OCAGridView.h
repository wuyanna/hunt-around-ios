//
//  OCAGridView.h
//  OCAFramework
//
//  Created by yutao on 12-9-21.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCAGridCell : UIView

@property (nonatomic) BOOL selected;
@property (nonatomic) BOOL highlighted;

@end

@protocol OCAGridViewDataSource,OCAGridViewDelegate;
@interface OCAGridView : UIView<
UITableViewDelegate,
UITableViewDataSource>
{
	UITableView *_tableView;
	NSArray *_list;			//NVIcon Objects
	
	NSInteger maxColumn;
	float iconWidth;
	float iconHeight;
	
	BOOL _isEnd;
    NSString* _gridBgImageName;
    CGFloat _imageInset;
    CGFloat _imageOffset;
}

@property (nonatomic, retain) NSArray *list;
@property (nonatomic, assign) NSInteger maxColumn;
@property (nonatomic, assign) float iconWidth;
@property (nonatomic, assign) float iconHeight;
@property (nonatomic, assign) id <OCAGridViewDelegate> delegate;
@property (nonatomic, assign) id <OCAGridViewDataSource> dataSource;
@property (nonatomic, readonly) NSInteger notificationCount;
@property (nonatomic, assign) BOOL isEnd;
@property (nonatomic, retain) NSString* gridBgImageName;
@property (nonatomic, assign) CGFloat imageInset;
@property (nonatomic, assign) CGFloat imageOffset;
@end

@protocol OCAGridViewDataSource <NSObject>

@required
- (NSInteger)gridView:(OCAGridView *)gridView numberOfCellsInSection:(NSInteger)section;
- (OCAGridCell *)gridView:(OCAGridView *)gridView cellForIndex:(NSInteger)index inSection:(NSInteger)section;

@optional
- (NSInteger)numberOfSectionInGridView:(OCAGridView *)gridView;
- (NSInteger)gridView:(OCAGridView *)gridView numberOfMaxColumnInSection:(NSInteger)section;
@end

@protocol OCAGridViewDelegate <NSObject>

- (void)gridView:(OCAGridView *)gridView didSelectCellAtIndex:(NSInteger)index inSection:(NSInteger)section;
- (CGFloat)gridView:(OCAGridView *)gridView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)gridView:(OCAGridView *)gridView widthForColumnAtIndexPath:(NSIndexPath *)indexPath;
@end