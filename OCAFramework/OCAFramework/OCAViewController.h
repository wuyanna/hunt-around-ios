//
//  OCAViewController.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-2-28.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OCATabBarController;
@interface OCAViewController : UIViewController {

}

@property (nonatomic, assign) BOOL                  isTabbed;
@property (nonatomic, assign) OCATabBarController   *customTabBarController;


@end
