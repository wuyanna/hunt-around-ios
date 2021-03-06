//
//  CharacterController.m
//  HuntAround
//
//  Created by Hou yutao on 9/17/12.
//
//

#import "CharacterController.h"

@interface CharacterController() {
    UITableView *_tableView;
    OCASegmentedControl *_segmentedControl;
}
@end

@implementation CharacterController

- (id)init
{
    if (self = [super init]) {
        _segmentedControl = [[OCASegmentedControl alloc] initWithFrame:CGRectMake(10.0, 0.0, contentView.bounds.size.width, 40)];
        _segmentedControl.numberOfSegments = 3;
        [_segmentedControl setTitle:@"Profile" forSegmentAtIndex:0];
        [_segmentedControl setTitle:@"Inventory" forSegmentAtIndex:1];
        [_segmentedControl setTitle:@"Stats" forSegmentAtIndex:2];
        _segmentedControl.delegate = self;
        [_segmentedControl setBackgroundImage:[[UIImage imageNamed:@"huntsegment_s"] stretchableImageWithLeftCapWidth:30 topCapHeight:30] forState:OCASegmentedControlStateSelected AtPosition:OCASegmentedControlAll];
        [_segmentedControl setBackgroundImage:[[UIImage imageNamed:@"huntsegment"] stretchableImageWithLeftCapWidth:30 topCapHeight:30] forState:OCASegmentedControlStateNormal AtPosition:OCASegmentedControlAll];
        
        [contentView addSubview:_segmentedControl];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 40, contentView.bounds.size.width - 20, contentView.bounds.size.width - 40)];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [contentView addSubview:_tableView];
        
        [self setTitle:@"Profile"];
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

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
@end
