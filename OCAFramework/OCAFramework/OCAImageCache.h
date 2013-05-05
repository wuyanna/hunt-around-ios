//
//  OCAImageCache.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-3-6.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import <pthread.h>

@interface OCAImageCache : NSObject {
    NSString        *filename;
	NSInteger       maxCount;
	
	sqlite3         *db;
	pthread_mutex_t lock;
}

- (id)initWithFile:(NSString *)path maxCount:(NSInteger)max;

- (NSString *)filename;

- (NSInteger)maxCount;

- (NSData *)fetch:(NSString *)url;

- (BOOL)push:(NSData *)data forKey:(NSString *)url;

- (BOOL)cleanUp;

@end
