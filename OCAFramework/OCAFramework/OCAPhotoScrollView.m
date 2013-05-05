//
//  OCAPhotoScrollView.m
//  OCAFramework
//
//  Created by Wu Yanna on 12-4-8.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import "OCAPhotoScrollView.h"
#import "OCAHttpImageView.h"
@implementation OCAPhotoScrollView

@synthesize photos = _photos;
@synthesize photoUrls = _photoUrls;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setPhotos:(NSArray *)photos {
    if (_photos != photos) {
        [_photos release];
        _photos = [photos copy];
        
        NSMutableArray *photoViews = [NSMutableArray array]; 
        for (UIImage *photo in _photos) {
            UIImageView *photoView = [[UIImageView alloc] initWithImage:photo];
            [photoViews addObject:photoView];
            [photoView release];
        }
        self.pages = [NSArray arrayWithArray:photoViews];
    }
}

- (void)setPhotoUrls:(NSArray *)photoUrls {
    if (_photoUrls != photoUrls) {
        [_photoUrls release];
        _photoUrls = [photoUrls copy];
        
        NSMutableArray *photoViews = [NSMutableArray array]; 
        for (NSString *photo in _photoUrls) {
            OCAHttpImageView *photoView = [[OCAHttpImageView alloc] initWithFrame:self.bounds];
            photoView.url = [NSURL URLWithString:photo];
            [photoViews addObject:photoView];
            [photoView release];
        }
        self.pages = [NSArray arrayWithArray:photoViews];
    }
}

@end
