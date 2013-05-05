//
//  OCAHTableViewCell.m
//  OCAFramework
//
//  Created by Wu Yanna on 12-5-23.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import "OCAHTableViewCell.h"

@implementation OCAHTableViewCell
@synthesize contentView;
@synthesize reuseIdentifier = _reuseIdentifier;
@synthesize imageView;
@synthesize textLabel;
@synthesize detailTextLabel;

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

- (id)initWithStyle:(OCAHTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [self init];
    if (self) {
        self.reuseIdentifier = reuseIdentifier;
        contentView = [[UIView alloc] initWithFrame:self.bounds];
        textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        textLabel.numberOfLines = 0;
        textLabel.text = @"";
        imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        [self addSubview:contentView];
        [contentView addSubview:textLabel];
        [contentView addSubview:imageView];
        
    }
    return self;
}

- (void)layoutSubviews {
    contentView.frame = self.bounds;
    textLabel.frame = contentView.bounds;
    
    imageView.frame = CGRectMake(0.0, 0.0, 30, 30);
}

- (void)dealloc {
    self.reuseIdentifier = nil;
    [textLabel release];
    [imageView release];
    [contentView release];
    [super dealloc];
}



@end
