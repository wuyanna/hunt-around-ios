//
//  OCAByteCache.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-3-6.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import <pthread.h>
@interface OCAByteCache : NSObject {
    NSString            *filename;
	NSString            *name;
	time_t              lifetime;
	
	sqlite3             *db;
	pthread_rwlock_t    rwlock;
}

- (id)initWithFile:(NSString *)path name:(NSString *)tableName lifetime:(NSInteger)time;

- (NSString *)filename;

- (NSString *)name;

- (time_t)lifetime;

- (NSData *)fetch:(NSString *)url timestamp:(time_t *)time;

- (BOOL)push:(NSData *)data forKey:(NSString *)url;

- (BOOL)remove:(NSString *)url;

- (BOOL)cleanUp;

@end
