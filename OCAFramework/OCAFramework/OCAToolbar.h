//
//  OCAToolbar.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-5-19.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OCAToolbarDataSource;
@interface OCAToolbar : UIView {
    CGRect oriFrame;
}

@property (nonatomic, assign) id<OCAToolbarDataSource> datasource;
@property (nonatomic) BOOL vertical;
@property (nonatomic, retain) UIView    *backgoundView;
@property (nonatomic, retain) UIImage   *seperatorImage;
@property (nonatomic, readonly) NSInteger numberOfButtons;

- (void)reloadData;
- (void)retrieveToPoint:(CGPoint)dst withDuration:(CGFloat)interval;
- (void)showAtPoint:(CGPoint)dst fromPoint:(CGPoint)src withDuration:(CGFloat)interval;
@end


@protocol OCAToolbarDataSource <NSObject>

@required
- (NSInteger)numberOfButtonsInToolbar:(OCAToolbar *)toolbar;
- (UIButton *)toolbar:(OCAToolbar *)toolbar buttonForIndex:(NSInteger)index;

@end