//
//  OCAPhotoScrollView.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-4-8.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCAPageScrollView.h"

@interface OCAPhotoScrollView : OCAPageScrollView

@property (nonatomic, copy) NSArray *photos;
@property (nonatomic, copy) NSArray *photoUrls;
@end
