//
//  UIBarButtonItem+Custom.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-5-11.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Custom)

- (id)initWithTitle:(NSString *)title image:(UIImage *)image backgroudImage:(UIImage *)bgImage target:(id)target action:(SEL)selector;
@end
