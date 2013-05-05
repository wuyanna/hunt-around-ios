//
//  ShopController.m
//  HuntAround
//
//  Created by Hou yutao on 9/15/12.
//
//

#import "ShopController.h"
#import "ShopItemGridCell.h"
@interface ShopController() {
    OCAGridView *_gridView;
    OCASegmentedControl *_segmentedControl;
    NSArray *_itemList;
}
@end

@implementation ShopController

- (id)init
{
    if (self = [super init]) {
        _segmentedControl = [[OCASegmentedControl alloc] initWithFrame:CGRectMake(10.0, 0.0, contentView.bounds.size.width, 40)];
        _segmentedControl.numberOfSegments = 4;
        [_segmentedControl setTitle:@"Limited" forSegmentAtIndex:0];
        [_segmentedControl setTitle:@"Weapon" forSegmentAtIndex:1];
        [_segmentedControl setTitle:@"Armor" forSegmentAtIndex:2];
        [_segmentedControl setTitle:@"shoes" forSegmentAtIndex:3];
        [_segmentedControl setTitle:@"Accessory" forSegmentAtIndex:3];
        _segmentedControl.delegate = self;
        [_segmentedControl setBackgroundImage:[[UIImage imageNamed:@"huntsegment_s"] stretchableImageWithLeftCapWidth:30 topCapHeight:30] forState:OCASegmentedControlStateSelected AtPosition:OCASegmentedControlAll];
        [_segmentedControl setBackgroundImage:[[UIImage imageNamed:@"huntsegment"] stretchableImageWithLeftCapWidth:30 topCapHeight:30] forState:OCASegmentedControlStateNormal AtPosition:OCASegmentedControlAll];
        
        [contentView addSubview:_segmentedControl];
        
        _gridView = [[OCAGridView alloc] initWithFrame:CGRectMake(10, 40, contentView.bounds.size.width - 20, contentView.bounds.size.width - 40)];
        
        _gridView.dataSource = self;
        _gridView.delegate = self;
        [contentView addSubview:_gridView];
        
        [self setTitle:@"Shop"];
        
        _segmentedControl.selectedSegmentIndex = 0;
    }
    return self;
}

- (void)valueChanged:(OCASegmentedControl *)segmentedControl selectedSegmentIndex:(NSInteger)index {
    switch (index) {
        case 0:
            
            break;
            
        default:
            break;
    }
}

- (NSInteger)gridView:(OCAGridView *)gridView numberOfCellsInSection:(NSInteger)section {
    return 4;
//    return [_itemList count];
}

- (OCAGridCell *)gridView:(OCAGridView *)gridView cellForIndex:(NSInteger)index inSection:(NSInteger)section {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"ItemGridCell" owner:nil options:nil];
    ShopItemGridCell *cell = [views objectAtIndex:0];
    return cell;
}

- (CGFloat)gridView:(OCAGridView *)gridView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}
- (CGFloat)gridView:(OCAGridView *)gridView widthForColumnAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
@end
