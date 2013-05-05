//
//  OCALinkedListNode.m
//  OCAFramework
//
//  Created by Wu Yanna on 12-3-6.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import "OCALinkedListNode.h"

@implementation OCALinkedListNode

@synthesize obj;

- (void)remove {
	prev->next = next;
	next->prev = prev;
}

- (void)dealloc {
	[obj release];
	[super dealloc];
}

@end
