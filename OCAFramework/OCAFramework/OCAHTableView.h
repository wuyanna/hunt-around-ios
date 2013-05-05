//
//  OCAHTableView.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-5-22.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCAHTableViewCell.h"

typedef enum {
    OCAHTableViewStylePlain,                  // regular table view
    OCAHTableViewStyleGrouped                 // preferences style table view
} OCAHTableViewStyle;

// scroll so row of interest is completely visible at left/middle/right of view
typedef enum {
    OCAHTableViewScrollPositionNone,        
    OCAHTableViewScrollPositionLeft,    
    OCAHTableViewScrollPositionMiddle,   
    OCAHTableViewScrollPositionRight
} OCAHTableViewScrollPosition;

@class OCAHTableView;
@protocol OCAHTableViewDelegate <NSObject, UIScrollViewDelegate>

@optional
- (CGFloat)tableView:(OCAHTableView *)tableView widthForColumnAtIndexPath:(NSIndexPath *)indexPath;
// Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
- (NSIndexPath *)tableView:(OCAHTableView *)tableView willSelectColumnAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)tableView:(OCAHTableView *)tableView willDeselectColumnAtIndexPath:(NSIndexPath *)indexPath;
// Called after the user changes the selection.
- (void)tableView:(OCAHTableView *)tableView didSelectColumnAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(OCAHTableView *)tableView didDeselectColumnAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol OCAHTableViewDataSource;
@interface OCAHTableView : UIScrollView<UIScrollViewDelegate> {
    CGFloat                     _rowHeight;
    CGRect                      _visibleBounds;
    NSRange                     _visibleRows;
    NSMutableArray             *_visibleCells;
    NSMutableDictionary        *_reusableTableCells;
    NSMutableDictionary        *_cellRectDictionary;    // indexPath - rect
    NSMutableArray             *_selectedIndexPaths;
    unsigned int _selectedSection;
    unsigned int _selectedRow;
    unsigned int _lastSelectedSection;
    unsigned int _lastSelectedRow;
}

- (id)initWithFrame:(CGRect)frame style:(OCAHTableViewStyle)style;                // must specify style at creation. -initWithFrame: calls this with UITableViewStylePlain
@property(nonatomic,readonly) OCAHTableViewStyle            style;
@property(nonatomic,assign)   id <OCAHTableViewDataSource>  dataSource;
@property(nonatomic,assign)   id <OCAHTableViewDelegate>    delegate;
@property(nonatomic)          CGFloat                       rowHeight;             // will return the default value if unset
@property(nonatomic)          CGFloat                       sectionHeaderHeight;   // will return the default value if unset
@property(nonatomic)          CGFloat                       sectionFooterHeight;   // will return the default value if unset
@property(nonatomic,retain) UIView *tableHeaderView;                            // accessory view for above row content. default is nil. not to be confused with section header
@property(nonatomic,retain) UIView *tableFooterView;                            // accessory view below content. default is nil. not to be confused with section footer

- (void)reloadData;                 // reloads everything from scratch. redisplays visible rows. because we only keep info about visible rows, this is cheap. will adjust offset if table shrinks

- (NSInteger)numberOfSections;
- (NSInteger)numberOfColumnsInSection:(NSInteger)section;

- (CGRect)rectForSection:(NSInteger)section;                                    // includes header, footer and all rows
- (CGRect)rectForHeaderInSection:(NSInteger)section;
- (CGRect)rectForFooterInSection:(NSInteger)section;
- (CGRect)rectForColumnAtIndexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)indexPathForColumnAtPoint:(CGPoint)point;                         // returns nil if point is outside table
- (NSIndexPath *)indexPathForCell:(OCAHTableViewCell *)cell;                      // returns nil if cell is not visible
- (NSArray *)indexPathsForColumnInRect:(CGRect)rect;                              // returns nil if rect not valid 

- (OCAHTableViewCell *)cellForColumnAtIndexPath:(NSIndexPath *)indexPath;            // returns nil if cell is not visible or index path is out of range
- (NSArray *)visibleCells;
- (NSArray *)indexPathsForVisibleRows;

- (void)scrollToColumnAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(OCAHTableViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToNearestSelectedColumnAtScrollPosition:(OCAHTableViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;  // Used by the delegate to acquire an already allocated cell, in lieu of allocating a new one.
@end

@protocol OCAHTableViewDataSource <NSObject>

@required
//表单有几个Column
- (NSInteger)tableView:(OCAHTableView *)tableView numberOfColumnInSection:(NSInteger)section;

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
- (OCAHTableViewCell *)tableView:(OCAHTableView *)tableView cellForColumnAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSInteger)numberOfSectionsInTableView:(OCAHTableView *)tableView;              // Default is 1 if not implemented

- (NSString *)tableView:(OCAHTableView *)tableView titleForHeaderInSection:(NSInteger)section;    // fixed font style. use custom view (UILabel) if you want something different
- (NSString *)tableView:(OCAHTableView *)tableView titleForFooterInSection:(NSInteger)section;
@end