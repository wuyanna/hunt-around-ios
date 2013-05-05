//
//  OCALinkedList.m
//  OCAFramework
//
//  Created by Wu Yanna on 12-3-6.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import "OCALinkedList.h"

@implementation OCALinkedList

- (id)init {
	if(self = [super init]) {
		head = [[OCALinkedListNode alloc] init];
		head->next = head->prev = head;
	}
	return self;
}

- (OCALinkedListNode *)first {
	OCALinkedListNode *node = head->next;
	if(node == head)
		return nil;
	return node;
}

- (OCALinkedListNode *)last {
	OCALinkedListNode *node = head->prev;
	if(node == head)
		return nil;
	return node;
}

- (OCALinkedListNode *)addFirst:(OCALinkedListNode *)node {
	node->next = head->next;
	node->prev = head;
	node->prev->next = node;
	node->next->prev = node;
	return node;
}

- (OCALinkedListNode *)addLast:(OCALinkedListNode *)node {
	node->next = head;
	node->prev = head->prev;
	node->prev->next = node;
	node->next->prev = node;
	return node;
}

- (void)clear {
	OCALinkedListNode *node = [self last];
	while (node != nil) {
		[node remove];
		node = [self last];
	}
	head->next = head->prev = head;
}

- (void)dealloc {
	[head release];
	[super dealloc];
}

@end
