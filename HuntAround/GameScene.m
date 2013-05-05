//
//  GameScene.m
//  HuntAround
//
//  Created by yutao on 12-9-7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene

-(id) init
{
	if ((self = [super init])) {
        [self loadMap];
        
	}
	
	return self;
}

- (void)loadMap {
    [[MapController sharedInstance] loadView];
    [[PlayController sharedInstance] loadView];
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	CCLOG(@"dealloc: %@", self);
    
	[super dealloc];
}

@end
