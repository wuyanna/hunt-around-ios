//
//  ArenaController.m
//  HuntAround
//
//  Created by Hou yutao on 9/17/12.
//
//

#import "ArenaController.h"
#import "BuddyCell.h"

@interface ArenaController() {
    UITableView *_tableView;
    NSMutableArray *_array;
    OCASegmentedControl *_segmentedControl;
}
@end

@implementation ArenaController

- (id)init
{
    if (self = [super init]) {
        _segmentedControl = [[OCASegmentedControl alloc] initWithFrame:CGRectMake(10.0, 0.0, contentView.bounds.size.width, 40)];
        _segmentedControl.numberOfSegments = 4;
        [_segmentedControl setTitle:@"Challenge" forSegmentAtIndex:0];
        [_segmentedControl setTitle:@"Rank" forSegmentAtIndex:1];
        _segmentedControl.delegate = self;
        [_segmentedControl setBackgroundImage:[[UIImage imageNamed:@"huntsegment_s"] stretchableImageWithLeftCapWidth:30 topCapHeight:30] forState:OCASegmentedControlStateSelected AtPosition:OCASegmentedControlAll];
        [_segmentedControl setBackgroundImage:[[UIImage imageNamed:@"huntsegment"] stretchableImageWithLeftCapWidth:30 topCapHeight:30] forState:OCASegmentedControlStateNormal AtPosition:OCASegmentedControlAll];
        
        [contentView addSubview:_segmentedControl];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 40, contentView.bounds.size.width - 20, contentView.bounds.size.width - 40)];
        
        _array = [[NSMutableArray alloc] init];
        [_array addObject:@"1"];
        [_array addObject:@"1"];
        [_array addObject:@"1"];
        [_array addObject:@"1"];
        [_array addObject:@"1"];
        [_array addObject:@"1"];
        [_array addObject:@"1"];
        [_array addObject:@"1"];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [contentView addSubview:_tableView];
        
        [self setTitle:@"Arena"];
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

#pragma mark -
#pragma mark Table Data Source Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuddyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"buddy"];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"BuddyCell" owner:nil options:nil];
        cell = [nibs objectAtIndex:0];
    }
    
    NSInteger row = [indexPath row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
@end