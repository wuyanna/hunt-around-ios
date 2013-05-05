//
//  OCALinkedList.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-3-6.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCALinkedListNode.h"

@interface OCALinkedList : NSObject {
    OCALinkedListNode   *head;
}
- (OCALinkedListNode *)first;
- (OCALinkedListNode *)last;

- (OCALinkedListNode *)addFirst:(OCALinkedListNode *)node;

- (OCALinkedListNode *)addLast:(OCALinkedListNode *)node;

- (void)clear;

@end
