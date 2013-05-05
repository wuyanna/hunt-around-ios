//
//  OCAHttpImageView.h
//  OCAFramework
//
//  Created by yanna on 12-12-16.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface OCAHttpImageView : UIView<ASIHTTPRequestDelegate> {
    UIImageView *imageView;
    
}

@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) UIView *loadingView;
@property (nonatomic, retain) UIView *errorView;
@end
