//
//  PlayerIcon.m
//  HuntAround
//
//  Created by yutao on 12-9-11.
//
//

#import "PlayerIcon.h"

@implementation PlayerIcon
@synthesize player = _player;

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

- (void)refreshData {
    levelLbl.text = self.player.level;
    nameLbl.text = self.player.username;
    expLbl.text = [NSString stringWithFormat:@"%d", self.player.exp];
    repLbl.text = [NSString stringWithFormat:@"%d", self.player.rep];
    cashLbl.text = [NSString stringWithFormat:@"%d", self.player.cash];
    gemLbl.text = [NSString stringWithFormat:@"%d", self.player.gem];
    
    [expBar setProgress:(float)self.player.exp animated:YES];
    [hpBar setProgress:(float)self.player.hp animated:YES];
    [energyBar setProgress:(float)self.player.energy animated:YES];
    [staminaBar setProgress:(float)self.player.stamina animated:YES];
}

- (void)setPlayer:(UserObj *)player {
    if (player != _player) {
        [_player release];
        _player = [player retain];
        
        
    }
}

@end
