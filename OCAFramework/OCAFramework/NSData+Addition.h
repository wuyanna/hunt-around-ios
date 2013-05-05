//
//  NSData+Addition.h
//  OCAFramework
//
//  Base64
//  Gzip
//
//  Created by Wu Yanna on 12-3-6.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Addition)

+ (NSData *) dataFromBase64String:(NSString *)string;

// Returns range [start, null byte), or (NSNotFound, 0).
- (NSRange) rangeOfNullTerminatedBytesFrom:(int)start;

// GZIP
- (NSData *) gzipInflate;
- (NSData *) gzipDeflate;

@end
