//
//  BuddyCell.h
//  HuntAround
//
//  Created by Hou yutao on 9/17/12.
//
//

#import <UIKit/UIKit.h>
#import "UserObj.h"

@interface BuddyCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *image;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) UserObj *player;

@end
