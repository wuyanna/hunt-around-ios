//
//  PanelController.h
//  HuntAround
//
//  Created by yutao on 12-9-10.
//
//

#import <Foundation/Foundation.h>
#import "OCAFramework.h"
#import "cocos2d.h"

// 这些东西不应该暴露出来，应该写私有的。然后暴露接口
@interface PanelController : NSObject {
    UIView *panelView;
    UILabel *_titleLabel;
    UIButton *backBtn;
    UIView *contentView;
}

@property (nonatomic, readonly) UIView *view;

- (void)setTitle:(NSString *)title;
- (void)setContentView:(UIView *)newConttentView;

- (void)showPanel;
- (void)dismissPanel;

@end