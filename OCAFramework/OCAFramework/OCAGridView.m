//
//  OCAGridView.m
//  OCAFramework
//
//  Created by yutao on 12-9-21.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import "OCAGridView.h"

#define DEFAULT_COLUMN_COUNT 3

@implementation OCAGridCell
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.highlighted = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.highlighted) {
        self.selected = YES;
    }
}
@end

@implementation OCAGridView

@synthesize list = _list;
@synthesize delegate;
@synthesize dataSource;
@synthesize isEnd = _isEnd;
@synthesize gridBgImageName = _gridBgImageName;
@synthesize imageInset = _imageInset;
@synthesize imageOffset = _imageOffset;


- (void)setList:(NSArray *)aList {
	_list = aList;
	[_tableView reloadData];
}

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		_tableView = [[UITableView alloc] initWithFrame:self.bounds];
		_tableView.delegate = self;
		_tableView.dataSource = self;
		_tableView.backgroundColor = [UIColor clearColor];
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		[self addSubview:_tableView];
        self.gridBgImageName = @"photolist_bg.png";
        self.imageInset = 6.0;
        self.imageOffset = 0.0;
	}
	return self;
}

- (void)resize:(CGRect)frame {
    self.frame = frame;
    _tableView.frame = self.bounds;
}

- (void)reloadData {
    [_tableView reloadData];
}


#pragma mark -
#pragma mark Text height helper methods
-(CGFloat) heightForText:(NSString*)text withFont:(UIFont*) font lineBreakMode:(UILineBreakMode) mode withWidth:(CGFloat)width {
	if(text == nil || [text length] == 0)
		return 0;
	
	CGSize constraint = CGSizeMake(width, 4000.0f);
	CGSize theSize = [text sizeWithFont:font constrainedToSize:constraint lineBreakMode:mode];
	return theSize.height;
}

- (NSInteger)maxColumnInSection:(NSInteger)section {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(gridView:numberOfMaxColumnInSection:)]) {
        return [self.dataSource gridView:self numberOfMaxColumnInSection:section];
    }
    return DEFAULT_COLUMN_COUNT;
}

- (OCAGridCell *)cellForIndex:(NSInteger)index inSection:(NSInteger)section {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(gridView:cellForIndex:inSection:)]) {
        OCAGridCell *cell = [self.dataSource gridView:self cellForIndex:index inSection:section];
        if (cell == nil) {
            [NSException raise:@"Invalid value" format:@"cell for index cannot be nil"];
        } else {
            return cell;
        }
    }
    return nil;
}

- (NSInteger)numberOfCellsInSection:(NSInteger)section {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(gridView:numberOfCellsInSection:)]) {
        return [self.dataSource gridView:self numberOfCellsInSection:section];
    }
    return 0;
}

#pragma mark -
#pragma mark Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfSectionInGridView:)]) {
        return [self.dataSource numberOfSectionInGridView:self];
    }
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger total = [self numberOfCellsInSection:section];
    NSInteger maxCol = [self maxColumnInSection:section];
    if (total > 0) {
        return total/maxCol + ((total%maxCol)?1:0);
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.delegate && [self.delegate respondsToSelector:@selector(gridView:heightForRowAtIndexPath:)]) {
        return [self.delegate gridView:self heightForRowAtIndexPath:indexPath];
    }
    return 100;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = nil;
    
	NSInteger rowIndex = indexPath.row;
    NSInteger section = indexPath.section;
    
    static NSString *cellIdentifier = @"IconCell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSInteger maxCol = [self maxColumnInSection:section];
    int base = rowIndex * maxCol;
    
    int xpos = 0;
    
    for (UIView *subview in cell.contentView.subviews) {
        if ([subview isKindOfClass:[OCAGridCell class]]) {
            [subview removeFromSuperview];
        }
    }
    
    NSInteger cellsNo = [self numberOfCellsInSection:section];
    CGRect rect = [_tableView rectForRowAtIndexPath:indexPath];
    float width = rect.size.width/maxCol;
    
    float height = rect.size.height;
    for (int i=0; i < maxCol; i++) {
        int index = base + i;
        if (index < cellsNo) {
            
            OCAGridCell *iconView = [self cellForIndex:index inSection:section];
            if (self.delegate && [self.delegate respondsToSelector:@selector(gridView:widthForColumnAtIndexPath:)]) {
                width = [self.delegate gridView:self widthForColumnAtIndexPath:[NSIndexPath indexPathForRow:i inSection:section]];
            }
            [cell.contentView addSubview:iconView];
            
            iconView.frame = CGRectMake(xpos, 0, width, height + 5);
            xpos += width;
        }
        
    }
    return cell;
}

#pragma mark -
#pragma mark NVGridIconViewDelegate


- (void)dealloc {
    [_tableView release];
	self.delegate = nil;
    self.gridBgImageName = nil;
    [super dealloc];
}



@end
