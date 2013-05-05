//
//  OCAEditableCell.m
//  OCAFramework
//
//  Created by Wu Yanna on 12-4-17.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import "OCAEditableCell.h"

@implementation OCAEditableCell

@synthesize textView;
@synthesize titleLbl;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
