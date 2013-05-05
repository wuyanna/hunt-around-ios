//
//  BuddyCell.m
//  HuntAround
//
//  Created by Hou yutao on 9/17/12.
//
//

#import "BuddyCell.h"

@implementation BuddyCell
@synthesize image = _image;
@synthesize nameLabel = _nameLabel;
@synthesize player = _player;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setPlayer:(UserObj *)player {
    if (player != _player) {
        [_player release];
        _player = [player retain];
        
        _nameLabel.text = _player.username;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_image release];
    [_nameLabel release];
    [super dealloc];
}
@end
