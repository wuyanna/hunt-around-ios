//
//  OCASwitchImageView.m
//  OCAFramework
//
//  Created by Wu Yanna on 12-4-22.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import "OCASwitchImageView.h"

@implementation OCASwitchImageView
@synthesize stateOnImage;
@synthesize stateOffImage;
@synthesize on;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setStateOnImage:(UIImage *)aImage {
    if (aImage != stateOnImage) {
        [stateOnImage release];
        stateOnImage = [aImage retain]; // 这里retain会造成内存泄露吗？
        
        self.image = on ? stateOnImage : stateOffImage;
    }
}

- (void)setStateOffImage:(UIImage *)aImage {
    if (aImage != stateOffImage) {
        [stateOffImage release];
        stateOffImage = [aImage retain];
        
        self.image = on ? stateOnImage : stateOffImage;
    }
}

- (void)setOn:(BOOL)b {
    if (b != on) {
        on = b;
        
        self.image = on ? stateOnImage : stateOffImage;
    }
}



- (void)dealloc {
    self.stateOnImage = nil;
    self.stateOffImage = nil;
    
    [super dealloc];
}

@end
