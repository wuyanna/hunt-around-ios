//
//  SWTableViewSpriteCell.m
//  PingPing2
//
//  Created by Sangwoo Im on 10/22/10.
//  Copyright 2010 Sangwoo Im. All rights reserved.
//

#import "SWTableViewSpriteCell.h"

@interface SWTableViewSpriteCell()
@property (nonatomic, retain) CCSprite *_sprite;

@end


@implementation SWTableViewSpriteCell
@synthesize _sprite;
@dynamic    sprite;

-(void)setSprite:(CCSprite *)s {
    if (_sprite) {
        [self removeChild:_sprite cleanup:YES];
    }
    s.anchorPoint = s.position = CGPointZero;
    self._sprite = s;
    [self addChild:_sprite];
}
-(CCSprite *)sprite {
    return _sprite;
}
-(void)reset {
    [super reset];
    if (_sprite) {
        [self removeChild:_sprite cleanup:YES];
    }
    self._sprite = nil;
}
-(void)dealloc {
    [_sprite release];
    [super dealloc];
}
@end