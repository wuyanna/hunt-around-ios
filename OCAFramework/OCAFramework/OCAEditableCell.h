//
//  OCAEditableCell.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-4-17.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCAEditableCell : UITableViewCell

@property (nonatomic, retain) IBOutlet  UILabel     *titleLbl;
@property (nonatomic, retain) IBOutlet  UITextView  *textView;

@end
