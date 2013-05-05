//
//  PanelController.m
//  HuntAround
//
//  Created by yutao on 12-9-10.
//
//

#import "PanelController.h"

@implementation PanelController
@synthesize view = panelView;

- (id)init {
    if (self = [super init]) {
        // panelView
        panelView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
        panelView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"panelbg"]];
        
        // backBtn
        backBtn = [[UIButton alloc] initWithFrame:CGRectMake(panelView.frame.size.width - 30, 10, 20, 20)];
        [backBtn setImage:[UIImage imageNamed:@"closebtn"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(dismissPanel) forControlEvents:UIControlEventTouchUpInside];
        [panelView addSubview:backBtn];
        
        // title
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 30)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textColor = [UIColor whiteColor];
        [panelView addSubview:_titleLabel];
        
        // contentView
        contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 320, 320)];
        [panelView addSubview:contentView];

    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

- (void)showPanel {
    [self retain];
    [[[[CCDirector sharedDirector] view] superview] addSubview:self.view];
}

- (void)dismissPanel {
    [self.view removeFromSuperview];
    [self release];
}

- (void)dealloc {
    [panelView release];
    
    [super dealloc];
}
@end
