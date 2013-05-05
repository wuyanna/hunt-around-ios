//
//  OCAHTableView.m
//  OCAFramework
//
//  Created by Wu Yanna on 12-5-22.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import "OCAHTableView.h"

#define DEFAULT_CELL_WIDTH  44

@interface OCAHTableView (Private)
- (void)initialize;
- (void)clear;
- (void)adjustCells;
- (void)calculate;
@end

@implementation OCAHTableView
@synthesize style = _style;
@synthesize dataSource = _dataSource;
@synthesize delegate = _tDelegate;
@synthesize rowHeight = _rowHeight;
@synthesize sectionFooterHeight = _sectionFooterHeight;
@synthesize sectionHeaderHeight = _sectionHeaderHeight;
@synthesize tableHeaderView = _tableHeaderView;
@synthesize tableFooterView = _tableFooterView;

- (id)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame style:OCAHTableViewStylePlain];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(OCAHTableViewStyle)style {
    self = [super initWithFrame:frame];
    if (self) {
        if (style == OCAHTableViewStylePlain) {
            
        }
        [self initialize];
        
    }
    return self;
}

- (void)awakeFromNib {
    [self initialize];
}

- (void)setTableHeaderView:(UIView *)tableHeaderView {
    if (_tableHeaderView != tableHeaderView) {
        [_tableHeaderView removeFromSuperview];
        [_tableHeaderView release];
        _tableHeaderView = [tableHeaderView retain];
        [self reloadData];
        if (_tableHeaderView) {
            CGRect frame = _tableHeaderView.frame;
            frame.origin.x = 0;
            _tableHeaderView.frame = frame;
            [self addSubview:_tableHeaderView];
        } 
        [self reloadData];
    }
}

- (void)setTableFooterView:(UIView *)tableFooterView {
    if (_tableFooterView != tableFooterView) {
        [_tableFooterView removeFromSuperview];
        [_tableFooterView release];
        _tableFooterView = [tableFooterView retain];
        [self reloadData];
        if (_tableFooterView) {
            CGRect frame = _tableFooterView.frame;
            frame.origin.x = _rowHeight + _tableHeaderView.frame.size.width;
            _tableFooterView.frame = frame;
            [self addSubview:_tableFooterView];
        }
        [self reloadData];
    }
}

- (void)initialize {
    [super setDelegate:self];
    [_visibleCells release];
    _visibleCells = [[NSMutableArray alloc] init];
    [_reusableTableCells release];
    _reusableTableCells = [[NSMutableDictionary alloc] init];
    [_cellRectDictionary release];
    _cellRectDictionary = [[NSMutableDictionary alloc] init];
    _visibleBounds = self.bounds;
    self.clipsToBounds = YES;
//    self.scrollEnabled = NO;
    self.delaysContentTouches = NO;
    self.directionalLockEnabled = YES;
//    [self addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:self];
}

#pragma mark pinannotation observer
#pragma mark observer for "contentOffset" property 
//- (void)observeValueForKeyPath:(NSString *)keyPath
//					  ofObject:(id)object
//                        change:(NSDictionary *)change
//                       context:(void *)context
//{
//    if ([keyPath isEqual:@"contentOffset"]) {
//        [self calculate];
//    }
//}

// TODO: !! 在这里做计算会影响性能 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self calculate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([_tDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [_tDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([_tDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [_tDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)clear
{
    for (OCAHTableViewCell *cell  in _visibleCells) 
    {
        [cell removeFromSuperview];
    }
    [_visibleCells removeAllObjects];
    [_cellRectDictionary release];
    _cellRectDictionary = [[NSMutableDictionary alloc] init];
//    _visibleBounds = self.bounds;
    self.contentSize = CGSizeMake(0, 0);
}

- (NSInteger)numberOfSections {
    NSInteger sections = 1;
    if ([_dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [_dataSource numberOfSectionsInTableView:self];
    }
    return sections;
}
- (NSInteger)numberOfColumnsInSection:(NSInteger)section {
    NSInteger columns = 0;
    if ([_dataSource respondsToSelector:@selector(tableView:numberOfColumnInSection:)]) {
        columns = [_dataSource tableView:self numberOfColumnInSection:section];
    }
    return columns;
}

- (CGRect)rectForSection:(NSInteger)section {
    return CGRectZero;
}
- (CGRect)rectForHeaderInSection:(NSInteger)section {
    return CGRectZero;
}
- (CGRect)rectForFooterInSection:(NSInteger)section {
    return CGRectZero;
}

- (CGRect)rectForColumnAtIndexPath:(NSIndexPath *)indexPath {
    
    return [[_cellRectDictionary objectForKey:indexPath] CGRectValue];
}

- (void)calculatePosition {
    CGFloat width = self.tableHeaderView.frame.size.width;
    float widthSum = width;
    _rowHeight = 0;
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    int sections = [self numberOfSections];
    for (int i = 0; i < sections; i++) {
        int columns = [self numberOfColumnsInSection:i];
        for (int j = 0; j < columns; j++) {
            CGFloat columnWidth = DEFAULT_CELL_WIDTH;
            if ([_tDelegate respondsToSelector:@selector(tableView:widthForColumnAtIndexPath:)]) {
                columnWidth = [_tDelegate tableView:self widthForColumnAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
            }
            [_cellRectDictionary setObject:[NSValue valueWithCGRect:CGRectMake(widthSum, self.bounds.origin.y, columnWidth, self.bounds.size.height)] forKey:[NSIndexPath indexPathForRow:j inSection:i]];
            widthSum += columnWidth;
            _rowHeight += columnWidth;
        }
    }
    widthSum += self.tableFooterView.frame.size.width;
    [pool release];
    self.contentSize = CGSizeMake(widthSum,self.bounds.size.height);
    if (_visibleBounds.size.width + _visibleBounds.origin.x > self.contentSize.width) {
        _visibleBounds = self.bounds;
    }
}

- (void)reloadData {
    if (_dataSource != nil) {
        [self clear];
        [self calculatePosition];
        
        [self calculate];
    }
}

//计算
-(void)calculate
{
    CGFloat offsetX = self.contentOffset.x;
    _visibleBounds.origin.x = offsetX;
    
    NSMutableArray *invalidCells = [NSMutableArray arrayWithCapacity:4];
    NSArray *indexes = [self indexPathsForColumnInRect:_visibleBounds];
//    NSLog(@"visible indexes:%@",indexes);
    NSMutableArray *oldIndexes = [NSMutableArray arrayWithCapacity:4];

    for (OCAHTableViewCell *cell in _visibleCells) {
        NSIndexPath *indexPath = [self indexPathForCell:cell];
        if (indexPath != nil) {
            [oldIndexes addObject:[self indexPathForCell:cell]];
        } else {
            [cell removeFromSuperview];
            [invalidCells addObject:cell];
        }
        
    }
    
    [_visibleCells removeObjectsInArray:invalidCells];
    
    //增加新增的
    for (NSIndexPath *path in indexes) {
        
        if (![oldIndexes containsObject:path]) {
            OCAHTableViewCell *cell = [self cellForColumnAtIndexPath:path];
            [_visibleCells addObject:cell];
            cell.frame = [self rectForColumnAtIndexPath:path];
            [self addSubview:cell];
        }
        
    }
//    NSLog(@"visible cells:%@",_visibleCells);
}

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    return [_reusableTableCells objectForKey:identifier];
}

- (void)adjustCells {
    if (self.contentOffset.x > 0) {
        _visibleBounds.origin.x += self.contentOffset.x;
    }
    
}

- (OCAHTableViewCell *)cellForColumnAtIndexPath:(NSIndexPath *)indexPath {
    if (_dataSource) {
        return [_dataSource tableView:self cellForColumnAtIndexPath:indexPath];
    }
    return nil;
}

- (NSArray *)visibleCells {
    
}

- (NSArray *)indexPathsForVisibleRows {
    
}

- (NSIndexPath *)indexPathForColumnAtPoint:(CGPoint)point {
    NSEnumerator *enumerator = [_cellRectDictionary objectEnumerator];
    
    id value;
    while (value = [enumerator nextObject]) {
        CGRect rect = [value CGRectValue];
        CGRect offRect = CGRectOffset(rect, -self.contentOffset.x, 0.0);
        if (CGRectContainsPoint(offRect, point)) {
            NSArray *keys = [_cellRectDictionary allKeysForObject:[NSValue valueWithCGRect:rect]];
            NSIndexPath *key = [keys objectAtIndex:0]; 
            return key;
        }
        
    }
    return nil;
    
}

- (NSIndexPath *)indexPathForCell:(OCAHTableViewCell *)cell {
//    returns nil if cell is not visible
    if (CGRectContainsRect(_visibleBounds, cell.frame) || CGRectIntersectsRect(_visibleBounds, cell.frame)) {
        NSArray *keys = [_cellRectDictionary allKeysForObject:[NSValue valueWithCGRect:cell.frame]];
        NSIndexPath *key = [keys objectAtIndex:0]; 
        return key;
    }
    return nil;
}

- (NSArray *)indexPathsForColumnInRect:(CGRect)rect {
//    returns nil if rect not valid 
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:4];
    NSEnumerator *enumerator = [_cellRectDictionary objectEnumerator];
    id value;
    while (value = [enumerator nextObject]) {
        CGRect cellrect = [value CGRectValue];
        if (CGRectContainsRect(rect, cellrect) || CGRectIntersectsRect(rect, cellrect)) {
            NSArray *keys = [_cellRectDictionary allKeysForObject:[NSValue valueWithCGRect:cellrect]]; 
            [tempArray addObjectsFromArray:keys];
        }
    }
    return [NSArray arrayWithArray:tempArray];
}

@end
