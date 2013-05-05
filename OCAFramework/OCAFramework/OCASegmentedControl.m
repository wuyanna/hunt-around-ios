//
//  OCASegmentedControl.m
//  OCAFramework
//
//  Created by Wu Yanna on 12-3-6.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import "OCASegmentedControl.h"
@interface OCASegmentedControl (Private)
- (void)defaultInitialization;
@end
@implementation OCASegmentedControl

@synthesize selectedSegmentIndex;
@synthesize numberOfSegments;
@synthesize delegate;
@synthesize enabled;
@synthesize dividerImage;
@synthesize dividerWidth;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc {
    [_dividers release];
    [dividerImage release];
    [_buttonArray release];
    [super dealloc];
}

- (void)layoutSubviews {
    
    float segmentWidth = self.frame.size.width / [_buttonArray count];
    float segmentStartX = 0;
    for (int i = 0; i < [_buttonArray count]; i++) {
        UIButton *button = [_buttonArray objectAtIndex:i];
        button.frame = CGRectMake(segmentStartX, 0, segmentWidth, self.frame.size.height);
        segmentStartX += segmentWidth;
    }
    
    float dividerWdt = self.dividerWidth > 0 ? self.dividerWidth : 1;
    float dividerStartX = segmentWidth-dividerWdt/2;
    for (int j = 0; j < [_dividers count]; j++) {
        UIImageView *divider = [_dividers objectAtIndex:j];
        divider.frame = CGRectMake(dividerStartX, 0.0, divider.image.size.width, self.frame.size.height);
        dividerStartX += segmentWidth;
    }
}

- (void)setEnabled:(BOOL)aEnabled {
    for (int i = 0; i < [_buttonArray count]; i++) {
        UIButton *button = [_buttonArray objectAtIndex:i];
        [button setEnabled:aEnabled];
    }
}

- (void)setNumberOfSegments:(NSUInteger)aNumberOfSegments {
    numberOfSegments = aNumberOfSegments;
    [_buttonArray release];
    [_dividers release];
    _buttonArray = [[NSMutableArray arrayWithCapacity:numberOfSegments] retain];
    _dividers = [[NSMutableArray arrayWithCapacity:numberOfSegments-1] retain];
    for (int i=0; i <numberOfSegments; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //778bad
        [button titleLabel].font = [UIFont systemFontOfSize :15];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.titleLabel.shadowOffset = CGSizeMake(0.0, -1.0);
        [button setTitleShadowColor:[UIColor colorWithRed:193.0/255.0 green:85.0/255.0 blue:2.0/255.0 alpha:1] forState:UIControlStateSelected];
        [button setTitleShadowColor:[UIColor clearColor] forState:UIControlStateNormal];
        [button setTag:i];
        [button addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventAllTouchEvents];
        [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchDown];
        
        [_buttonArray addObject:button];
        [self addSubview:button];
        
        if (self.dividerImage) {
            
            UIImageView *divider = [[UIImageView alloc] initWithImage:self.dividerImage];
            if(i < aNumberOfSegments-1 )
            {
                [_dividers addObject:divider];
                [self addSubview:divider];
                
            }
        }
        
    }
    //    [self layoutIfNeeded];
}

- (void)setSelectedSegmentIndex:(NSInteger)aSelectedSegmentIndex {
	if (selectedSegmentIndex<_buttonArray.count) {
		UIButton *preButton = [_buttonArray objectAtIndex:selectedSegmentIndex];
		preButton.selected = NO;
	}
    
    selectedSegmentIndex = aSelectedSegmentIndex;
	
	if (selectedSegmentIndex<_buttonArray.count) {
		UIButton *currentButton = [_buttonArray objectAtIndex:selectedSegmentIndex];
		currentButton.selected = YES;
	}
    
    
    
    if ([delegate respondsToSelector:@selector(valueChanged:selectedSegmentIndex:)]) {
        [delegate valueChanged:self selectedSegmentIndex:selectedSegmentIndex];
    }
}

- (void)setBackgroundImage:(UIImage *)backgroundImage forState:(OCASegmentedControlState)state AtPosition:(OCASegmentedControlPosition)position {
    if (position == OCASegmentedControlLeft) {
        [self setBackgroundImage:backgroundImage forState:state AtIndex:0];  
    } else if (position == OCASegmentedControlRight) {
        [self setBackgroundImage:backgroundImage forState:state AtIndex:numberOfSegments - 1];
    } else if (position == OCASegmentedControlMiddle) {
        for (int i = 1; i < numberOfSegments - 1; i++) {
            [self setBackgroundImage:backgroundImage forState:state AtIndex:i];
        }
    } else {
        for (int i = 0; i < numberOfSegments; i++) {
            [self setBackgroundImage:backgroundImage forState:state AtIndex:i];
        }
    }
}

- (void)setBackgroundImage:(UIImage *)backgroundImage forState:(OCASegmentedControlState)state AtIndex:(NSInteger)index {
    if (index >= numberOfSegments) {
        NSLog(@"ERROR: Segment index:%d out of bounds:[0 - %d]", index, numberOfSegments-1);
        return;
    }
    
    UIButton *button = [_buttonArray objectAtIndex:index];
    if (state == OCASegmentedControlStateNormal) {
        [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    }else if (state == OCASegmentedControlStateSelected) {
        [button setBackgroundImage:backgroundImage forState:UIControlStateHighlighted];
        [button setBackgroundImage:backgroundImage forState:UIControlStateSelected];
    }
}

- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)segment {
    UIButton *button = [_buttonArray objectAtIndex:segment];
    [button setTitle:title forState:UIControlStateNormal];
}

- (void)touchAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = YES;
    button.highlighted = NO;
}
- (void)action:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (button.tag == selectedSegmentIndex) {
        return;
    }
    [self setSelectedSegmentIndex:button.tag];
}

- (UIButton*) buttonForIndex:(int)index
{
    if(_buttonArray!=nil && _buttonArray.count>index)
    {
        return [_buttonArray objectAtIndex:index];
    }
    return nil;
}

@end
