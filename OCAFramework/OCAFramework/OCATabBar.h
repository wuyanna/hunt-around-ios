//
//  OCATabBar.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-2-28.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OCATabBarDelegate;
@interface OCATabBar : UIView {
    NSArray*                _items;
    NSMutableArray*         _itmButtons;
    UITabBarItem*           _selectedItem;
    NSUInteger              _selectedIndex;
    id<OCATabBarDelegate>   _delegate;
    UIImage*                _highlightedImage;
    UIImage*                _selectedImage;
    UIImage*                _backgroundImage;
    
    UIImageView*            _backgroundImageView;
}

@property(nonatomic, copy)      NSArray*                items;
@property(nonatomic, assign)    UITabBarItem*           selectedItem;
@property(nonatomic, assign)    id<OCATabBarDelegate>   delegate;
@property(nonatomic, retain)    UIImage*                highlightedImage;
@property(nonatomic, retain)    UIImage*                selectedImage;
@property(nonatomic, retain)    UIImage*                backgroundImage;

- (NSUInteger)indexForItem:(UITabBarItem*)item;

@end

@protocol OCATabBarDelegate <NSObject>

@required
- (void)tabBar:(OCATabBar*)tb didSelectItem:(UITabBarItem *)i;


@end