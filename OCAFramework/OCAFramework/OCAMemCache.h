//
//  OCAMemCache.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-3-6.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCALinkedList.h"

@interface OCAMemCache : NSObject {
    NSMutableDictionary *dict;
	OCALinkedList       *accessList;
	OCALinkedList       *ageList;
	
	size_t              maxCacheSize;
	size_t              cacheSize;
	
	time_t              maxLifetime;
	
	volatile int32_t    cacheHits;
	volatile int32_t    cacheMisses;
}

- (id)initWithMaxSize:(size_t)ms maxLifetime:(time_t)ml;

- (id)putObject:(id)obj forKey:(id)key;
- (id)putObject:(id)obj forKey:(id)key timestamp:(time_t)time;
- (id)objectForKey:(id)key;
- (id)removeObjectForKey:(id)key;
- (void)clear;

- (NSInteger)count;
- (BOOL)isEmpty;

- (int32_t)cacheHits;
- (int32_t)cacheMisses;

- (size_t)maxCacheSize;
- (size_t)cacheSize;
- (void)setCacheSize:(size_t)size;

- (time_t)maxLifetime;
- (void)setMaxLifetime:(time_t)lifetime;

- (size_t)sizeOf:(id)obj;

- (void)cleanExpired;
- (void)cleanFull;
@end
