//
//  UIBarButtonItem+Custom.m
//  OCAFramework
//
//  Created by Wu Yanna on 12-5-11.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import "UIBarButtonItem+Custom.h"

@implementation UIBarButtonItem (Custom)
- (id)initWithTitle:(NSString *)title image:(UIImage *)image backgroudImage:(UIImage *)bgImage target:(id)target action:(SEL)selector {
    
    
    UIButton *itemBtn = [[[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 48, 30)] autorelease];
    
    self = [self initWithCustomView:itemBtn];
    if (self) {
        [itemBtn setTitle:title forState:UIControlStateNormal];
        itemBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13.0];
        [itemBtn setImage:image forState:UIControlStateNormal];
        [itemBtn setBackgroundImage:bgImage forState:UIControlStateNormal];
        [itemBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
@end
