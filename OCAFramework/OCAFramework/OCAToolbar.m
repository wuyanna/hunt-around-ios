//
//  OCAToolbar.m
//  OCAFramework
//
//  Created by Wu Yanna on 12-5-19.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import "OCAToolbar.h"

@implementation OCAToolbar

@synthesize datasource = _datasource;
@synthesize backgoundView = _backgroundView;
@synthesize seperatorImage = _seperatorImage;
@synthesize vertical;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        oriFrame = frame;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)setDatasource:(id<OCAToolbarDataSource>)datasource {
    if (_datasource != datasource) {
        _datasource = datasource;
        [self reloadData];
    }
}

- (NSInteger)numberOfButtons {
    return [_datasource numberOfButtonsInToolbar:self];
}

- (void)reloadData {
    for (UIView *sub in self.subviews) {
        if ([sub isKindOfClass:[UIButton class]]) {
            [sub removeFromSuperview];
        }
    }
//    CGFloat offset = 0;
    
    for (int i = 0; i < self.numberOfButtons; i++) {
        UIButton *btn = [_datasource toolbar:self buttonForIndex:i];
        if (btn == nil) {
            [NSException raise:@"Invalid value" format:@"button for index cannot be nil"];
        } else {
            [self addSubview:btn];
        }
    }
}

- (void)retrieveToPoint:(CGPoint)dst withDuration:(CGFloat)interval {
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:interval animations:^{
        CGRect f = self.frame;
        self.frame = self.vertical ? CGRectMake(dst.x,dst.y,f.size.width,0.1) :CGRectMake(dst.x,dst.y,0.1,f.size.height);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (void)showAtPoint:(CGPoint)dst fromPoint:(CGPoint)src withDuration:(CGFloat)interval {
    self.frame = self.vertical ? CGRectMake(src.x,src.y,oriFrame.size.width,0.1) :CGRectMake(src.x,src.y,0.1,oriFrame.size.height);
    self.userInteractionEnabled = YES;

    
    [UIView animateWithDuration:interval animations:^{
        self.frame = CGRectMake(dst.x,dst.y,oriFrame.size.width,oriFrame.size.height);
    }];
    self.hidden = NO;    
}



@end
