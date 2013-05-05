//
//  PlayController.m
//  HuntAround
//
//  Created by yutao on 12-9-10.
//
//

#import "PlayController.h"
#import "MapController.h"
#import "ContentFactory.h"
#import "BuddyController.h"

@implementation PlayController
@synthesize view;
+ (PlayController *)sharedInstance {
    static PlayController *ins = nil;
    if (ins == nil) {
        ins = [[PlayController alloc] init];
    }
    return ins;
}

- (UIView *)view {
    return [[MapController sharedInstance] view];
}

- (id)init {
    if (self = [super init]) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"PlayerIcon" owner:nil options:nil];
        pInfoView = [views objectAtIndex:0];
        
        rBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 400, 40, 40)];
        [rBtn setImage:[UIImage imageNamed:@"icon-72"] forState:UIControlStateNormal];
        [rBtn addTarget:self action:@selector(rBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
        
        vBar = [[OCAToolbar alloc] initWithFrame:CGRectMake(rBtn.frame.origin.x, rBtn.frame.origin.y - 100, 40.0,100.0)];
        vBar.vertical = YES;
        vBar.datasource = self;
        hBar = [[OCAToolbar alloc] initWithFrame:CGRectMake(rBtn.frame.origin.x + rBtn.frame.size.width + 20, rBtn.frame.origin.y, 200.0, 40.0)];
        hBar.vertical = NO;
        hBar.datasource = self;
       
    }
    return self;
}

- (void)loadView {
    [self.view addSubview:pInfoView];
    [self.view addSubview:vBar];
    [self.view addSubview:hBar];
    [self.view addSubview:rBtn];
}

- (UIButton *)toolbar:(OCAToolbar *)toolbar buttonForIndex:(NSInteger)index {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 40.0, 40.0)];
    CGRect f = btn.frame;
    [btn addTarget:self action:@selector(showPanel:) forControlEvents:UIControlEventTouchUpInside];
    if (toolbar == vBar) {
        if (index == 0) {
            [btn setImage:[UIImage imageNamed:@"icon-72"] forState:UIControlStateNormal];
            btn.tag = PanelIndexJob;
            return btn;
        }
        if (index == 1) {
            [btn setImage:[UIImage imageNamed:@"icon-72"] forState:UIControlStateNormal];
            f.origin.y = f.size.height + 10;
            btn.frame = f;
            btn.tag = PanelIndexArena;
            return btn;
        }
    } else if (toolbar == hBar) {
        if (index == 0) {
            [btn setImage:[UIImage imageNamed:@"icon-72"] forState:UIControlStateNormal];
            btn.tag = PanelIndexBuddy;
            return btn;
        }
        if (index == 1) {
            [btn setImage:[UIImage imageNamed:@"icon-72"] forState:UIControlStateNormal];
            f.origin.x = f.size.width + 10;
            btn.frame = f;
            btn.tag = PanelIndexShop;
            return btn;
        }
        if (index == 2) {
            [btn setImage:[UIImage imageNamed:@"icon-72"] forState:UIControlStateNormal];
            f.origin.x = 2 * (f.size.width + 10);
            btn.frame = f;
            btn.tag = PanelIndexCharacter;
            return btn;
        }
        if (index == 3) {
            [btn setImage:[UIImage imageNamed:@"icon-72"] forState:UIControlStateNormal];
            f.origin.x = 3 * (f.size.width + 10);
            btn.frame = f;
            btn.tag = PanelIndexInfo;
            return btn;
        }
    }
    return nil;
}

- (NSInteger)numberOfButtonsInToolbar:(OCAToolbar *)toolbar {
    if (toolbar == vBar) {
        return 2;
    } else if (toolbar == hBar) {
        return 4;
    }
    return 0;
}

- (void)showPanel:(id)sender {
    UIButton *btn = (UIButton *)sender;
    PanelIndex idx = btn.tag;
    PanelController *p = [ContentFactory createPanel:idx];
    [p showPanel];
}

- (void)rBtnTouched:(id)sender {
    if (toolsHided) {
        [vBar showAtPoint:CGPointMake(rBtn.frame.origin.x, rBtn.frame.origin.y - 100) fromPoint:rBtn.frame.origin withDuration:0.2];
        [hBar showAtPoint:CGPointMake(rBtn.frame.origin.x + rBtn.frame.size.width + 20, rBtn.frame.origin.y) fromPoint:rBtn.frame.origin withDuration:0.2];
        toolsHided = NO;
    } else {
        [vBar retrieveToPoint:rBtn.frame.origin withDuration:0.2];
        [hBar retrieveToPoint:rBtn.frame.origin withDuration:0.2];
        toolsHided = YES;
    }
}

@end
