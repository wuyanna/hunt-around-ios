//
//  PlayController.h
//  HuntAround
//
//  Created by yutao on 12-9-10.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "OCAFramework.h"
#import "PlayerIcon.h"

@interface PlayController : NSObject<OCAToolbarDataSource> {
    PlayerIcon *pInfoView;
    
    UIButton *rBtn;
    OCAToolbar *vBar;
    OCAToolbar *hBar;
    
    BOOL toolsHided;
    
}

+ (PlayController *)sharedInstance;
- (void)loadView;
@property (nonatomic, readonly) UIView *view;
@end
