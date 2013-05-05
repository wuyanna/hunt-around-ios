//
//  OCASwitchImageView.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-4-22.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCASwitchImageView : UIImageView {
    
}

@property (nonatomic, retain) UIImage   *stateOnImage;
@property (nonatomic, retain) UIImage   *stateOffImage;
@property (nonatomic, assign) BOOL      on;

@end
