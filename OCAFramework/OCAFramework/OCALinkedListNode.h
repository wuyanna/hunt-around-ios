//
//  OCALinkedListNode.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-3-6.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCALinkedListNode : NSObject {
    @public OCALinkedListNode   *prev;
    @public OCALinkedListNode   *next;
    
    id obj;
    
    @public time_t time;
}

@property (nonatomic, retain) id obj;

- (void)remove;

@end
