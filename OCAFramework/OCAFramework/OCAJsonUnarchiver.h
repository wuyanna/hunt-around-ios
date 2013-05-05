//
//  OCAJsonUnarchiver.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-4-18.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCAJsonUnarchiver : NSCoder {
    // 用于嵌套解析（指定当前在解析的对象）
    id          currentObj;
    
    NSMutableArray     *jsonStack;
}

+ (id)unarchiveObjectOfClass:(Class)cls withData:(NSData *)data encoding:(NSStringEncoding)encoding;
+ (id)unarchiveObjectOfClass:(Class)cls withJSONValue:(id)jsonValue;


- (BOOL)containsValueForKey:(NSString *)key;

- (id)decodeObject;
- (id)decodeObjectForKey:(NSString *)key;
- (BOOL)decodeBoolForKey:(NSString *)key;
- (int)decodeIntForKey:(NSString *)key;		// may raise a range exception
- (int32_t)decodeInt32ForKey:(NSString *)key;
- (int64_t)decodeInt64ForKey:(NSString *)key;
- (float)decodeFloatForKey:(NSString *)key;
- (double)decodeDoubleForKey:(NSString *)key;
- (const uint8_t *)decodeBytesForKey:(NSString *)key returnedLength:(NSUInteger *)lengthp;

// 如何与decodeObject合并
- (id)decodeCustomObjectOfClass:(Class)class forKey:(NSString *)key;
- (id)decodeArrayOfClass:(Class)class forKey:(NSString *)key;
- (id)decodeObject;
- (id)decodeCustomObjectOfClass:(Class)c;
- (id)decodeArrayOfClass:(Class)c;
@end
