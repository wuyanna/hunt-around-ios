//
//  OCACheckBox.m
//  OCAFramework
//
//  Created by Wu Yanna on 12-3-4.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import "OCACheckBox.h"

@implementation OCACheckBox

@synthesize isChecked;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.isChecked = NO;
        [self addTarget:self action:@selector(checkboxChecked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)checkboxChecked:(id)sender {
    self.isChecked = !isChecked;
}

- (void)setIsChecked:(BOOL)checked {
    if (isChecked != checked) {
        isChecked = checked;
        [self setImage:[UIImage imageNamed:(isChecked?@"":@"")] forState:UIControlStateNormal];
    }
}



@end
