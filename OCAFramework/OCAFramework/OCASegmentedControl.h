//
//  OCASegmentedControl.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-3-6.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    OCASegmentedControlStateNormal = 0,
    OCASegmentedControlStateSelected,
}OCASegmentedControlState;

typedef enum {
    OCASegmentedControlLeft = 0,
    OCASegmentedControlMiddle,
    OCASegmentedControlRight,
    OCASegmentedControlAll,
}OCASegmentedControlPosition;

@protocol OCASegmentedControlDelegate;
@interface OCASegmentedControl : UIView {
    NSInteger selectedSegmentIndex;
    NSMutableArray *_buttonArray;
    NSMutableArray *_dividers;
}
@property (nonatomic, assign)   id<OCASegmentedControlDelegate> delegate;
@property (nonatomic)           NSInteger                       selectedSegmentIndex;
@property (nonatomic)           NSUInteger                      numberOfSegments;
@property (nonatomic)           BOOL                            enabled;
@property (nonatomic, retain)   UIImage     *dividerImage;
@property (nonatomic)           CGFloat     dividerWidth;

- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)segment;
- (void)setBackgroundImage:(UIImage *)backgroundImage forState:(OCASegmentedControlState)state AtPosition:(OCASegmentedControlPosition)position;
- (void)setBackgroundImage:(UIImage *)backgroundImage forState:(OCASegmentedControlState)state AtIndex:(NSInteger)index;
- (UIButton*) buttonForIndex:(int)index;
@end

@protocol OCASegmentedControlDelegate <NSObject>

- (void)valueChanged:(OCASegmentedControl *)segmentedControl selectedSegmentIndex:(NSInteger)index;

@end
