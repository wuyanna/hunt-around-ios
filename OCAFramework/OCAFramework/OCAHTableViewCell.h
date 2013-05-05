//
//  OCAHTableViewCell.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-5-23.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    OCAHTableViewCellStyleDefault,
    OCAHTableViewCellStyleValue1,	
    OCAHTableViewCellStyleValue2,	
    OCAHTableViewCellStyleSubtitle
} OCAHTableViewCellStyle;

@interface OCAHTableViewCell : UIView

// If you want to customize cells by simply adding additional views, you should add them to the content view so they will be positioned appropriately as the cell transitions into and out of editing mode.
@property(nonatomic,readonly,retain) UIView       *contentView;
@property(nonatomic,copy) NSString       *reuseIdentifier;
@property(nonatomic,readonly,retain) UIImageView  *imageView;
@property(nonatomic,readonly,retain) UILabel      *textLabel;
@property(nonatomic,readonly,retain) UILabel      *detailTextLabel;



- (id)initWithStyle:(OCAHTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
