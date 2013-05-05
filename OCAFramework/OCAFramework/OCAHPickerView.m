//
//  OCAHPickerView.m
//  OCAFramework
//
//  Created by Wu Yanna on 12-5-22.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import "OCAHPickerView.h"
#define DEFAULT_COLUMN_WIDTH     44

@interface OCAHPickerView (Private)
- (void)initialize;
- (void)clear;
@end

@implementation OCAHPickerView
@synthesize delegate = _delegate;
@synthesize dataSource = _dataSource;
@synthesize showsSelectionIndicator = _showsSelectionIndicator;
@synthesize numberOfComponents = _numberOfComponents;
@synthesize backgroundView = _backgroundView;
@synthesize topFrame = _topFrame;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    [self initialize];
    [self reloadAllComponents];
}

- (void)initialize {
    [_backgroundView release];
    _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    [_pickerContentView release];
    _pickerContentView = [[UIView alloc] initWithFrame:self.bounds];
    _pickerContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    [_topFrame release];
    _topFrame = [[UIView alloc] initWithFrame:self.bounds];
    _topFrame.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    [_selectionBar release];
    _selectionBar = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - DEFAULT_COLUMN_WIDTH)/2, 0, DEFAULT_COLUMN_WIDTH, self.frame.size.height)];
    _selectionBar.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:_backgroundView];
    [self addSubview:_pickerContentView];
    [self addSubview:_topFrame];
    [_topFrame addSubview:_selectionBar];
    _topFrame.userInteractionEnabled = NO;
    [_tables release];
    _tables = [[NSMutableArray alloc] initWithCapacity:5];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (NSInteger)numberOfColumnsInComponent:(NSInteger)component {
    NSInteger columns = 0;
    if (_dataSource) {
        columns = [_dataSource pickerView:self numberOfColumnsInComponent:component];
    }
    return columns;
}

- (CGSize)columnSizeForComponent:(NSInteger)component {
    CGFloat width = DEFAULT_COLUMN_WIDTH;
    CGFloat height = 0;
    if ([_delegate respondsToSelector:@selector(pickerView:columnWidthForComponent:)]) {
        width = [_delegate pickerView:self columnWidthForComponent:component];
    }
    if ([_delegate respondsToSelector:@selector(pickerView:heightForComponent:)]) {
        height = [_delegate pickerView:self heightForComponent:component];
    }
    CGSize size = CGSizeMake(width, height > 0 ? height : self.frame.size.height / _numberOfComponents);
    return size;
    
}

// returns the view provided by the delegate via pickerView:viewForRow:forComponent:reusingView:
// or nil if the row/component is not visible or the delegate does not implement 
// pickerView:viewForRow:forComponent:reusingView:
- (UIView *)viewForColumn:(NSInteger)column forComponent:(NSInteger)component {
    if ([_delegate respondsToSelector:@selector(pickerView:viewForColumn:forComponent:reusingView:)]) {
        return [_delegate pickerView:self viewForColumn:column forComponent:component reusingView:nil];
    }
    return nil;
}

- (NSInteger)numberOfComponents {
    if ([_dataSource performSelector:@selector(numberOfComponentsInPickerView:)]) {
        return [_dataSource numberOfComponentsInPickerView:self];
    }
    return 1;
}

- (void)clear {
    for (OCAHTableView *table in _tables) {
        [table removeFromSuperview];
    }
    [_tables removeAllObjects];
}

- (void)reloadAllComponents {
    [self clear];
    _numberOfComponents = [self numberOfComponents];
    CGFloat height = 0;
    CGFloat sumHeight = 0;
    for (int i = 0; i < _numberOfComponents; i++) {
        
        height = [self columnSizeForComponent:i].height;
        OCAHTableView *table = [[OCAHTableView alloc] initWithFrame:CGRectMake(0, sumHeight, self.frame.size.width, height) style:OCAHTableViewStylePlain];
        table.dataSource = self;
        table.delegate = self;
        [_tables addObject:table];
        [_pickerContentView addSubview:table];
        [table release];
        [self reloadComponent:i];
        sumHeight += height;
    }
}

- (void)reloadComponent:(NSInteger)component {
    OCAHTableView *table = [_tables objectAtIndex:component];
    table.tableHeaderView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, (table.frame.size.width - DEFAULT_COLUMN_WIDTH)/2, table.frame.size.height)] autorelease];
    table.tableFooterView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, (table.frame.size.width - DEFAULT_COLUMN_WIDTH)/2, table.frame.size.height)] autorelease];
    [table reloadData];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[OCAHTableView class]]) {
        OCAHTableView *tableView = (OCAHTableView *)scrollView;
        int index = (tableView.contentOffset.x / DEFAULT_COLUMN_WIDTH);
        if ((int)tableView.contentOffset.x % ((int)DEFAULT_COLUMN_WIDTH) > DEFAULT_COLUMN_WIDTH / 2) {
            index++;
        } else if ((int)tableView.contentOffset.x % ((int)DEFAULT_COLUMN_WIDTH) < DEFAULT_COLUMN_WIDTH / 2) {
            
        }
        [tableView setContentOffset:CGPointMake(index*DEFAULT_COLUMN_WIDTH, 0) animated:YES];
        
        if ([_delegate respondsToSelector:@selector(pickerView:didSelectColumn:inComponent:)]) {
            [_delegate pickerView:self didSelectColumn:index inComponent:[_tables indexOfObject:tableView]];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([scrollView isKindOfClass:[OCAHTableView class]] && !decelerate) {
        OCAHTableView *tableView = (OCAHTableView *)scrollView;
        int index = (tableView.contentOffset.x / DEFAULT_COLUMN_WIDTH);
        if ((int)tableView.contentOffset.x % ((int)DEFAULT_COLUMN_WIDTH) > DEFAULT_COLUMN_WIDTH / 2) {
            index++;
        } else if ((int)tableView.contentOffset.x % ((int)DEFAULT_COLUMN_WIDTH) < DEFAULT_COLUMN_WIDTH / 2) {
            
        }
        [tableView setContentOffset:CGPointMake(index*DEFAULT_COLUMN_WIDTH, 0) animated:YES];
        
        if ([_delegate respondsToSelector:@selector(pickerView:didSelectColumn:inComponent:)]) {
            [_delegate pickerView:self didSelectColumn:index inComponent:[_tables indexOfObject:tableView]];
        }
    }
}

- (void)selectColumn:(NSInteger)column inComponent:(NSInteger)component animated:(BOOL)animated {
    OCAHTableView *table = [_tables objectAtIndex:component];
//    [table scrollToColumnAtIndexPath:[NSIndexPath indexPathForRow:column inSection:0] atScrollPosition:OCAHTableViewScrollPositionMiddle animated:animated];
    [table setContentOffset:CGPointMake(column*DEFAULT_COLUMN_WIDTH, 0) animated:animated];
    if (!animated) {
        if ([_delegate respondsToSelector:@selector(pickerView:didSelectColumn:inComponent:)]) {
            [_delegate pickerView:self didSelectColumn:column inComponent:component];
        }
    }
}

- (NSInteger)selectedColumnInComponent:(NSInteger)component {
    OCAHTableView *table = [_tables objectAtIndex:component];
    NSIndexPath *index = [table indexPathForColumnAtPoint:CGPointMake(table.frame.size.width/2, 0.0)];
    return index ? index.row : -1;
}

#pragma mark - TableView Datasource
- (NSInteger)tableView:(OCAHTableView *)tableView numberOfColumnInSection:(NSInteger)section {
    int columns = 0;
    if (_dataSource) {
        columns = [_dataSource pickerView:self numberOfColumnsInComponent:[_tables indexOfObject:tableView]];
    }
    return columns;
}

- (OCAHTableViewCell *)tableView:(OCAHTableView *)tableView cellForColumnAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger tIndex = [_tables indexOfObject:tableView];
    OCAHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"column_%d",tIndex]];
    if (cell == nil) {
        cell = [[[OCAHTableViewCell alloc] initWithStyle:OCAHTableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"column_%d",tIndex]] autorelease];
    }
    UIView *view = nil;
    if ([_delegate respondsToSelector:@selector(pickerView:viewForColumn:forComponent:reusingView:)]) {
        view = [_delegate pickerView:self viewForColumn:indexPath.row forComponent:tIndex reusingView:nil];
    }
    if ([_delegate respondsToSelector:@selector(pickerView:titleForColumn:forComponent:)]) {
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.textLabel.text = [_delegate pickerView:self titleForColumn:indexPath.row forComponent:tIndex];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
    }
    if (view) {
        view.frame = cell.bounds;
        [cell.contentView addSubview:view];
    }
    
    return cell;
}

- (void)dealloc {
    [_backgroundView release];
    [_pickerContentView release];
    [_topFrame release];
    [_tables release];
    [super dealloc];
}

@end
