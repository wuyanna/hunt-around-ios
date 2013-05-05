//
//  OCAJsonUnarchiver.m
//  OCAFramework
//
//  Created by Wu Yanna on 12-4-18.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import "OCAJsonUnarchiver.h"
#import "JSON.h"

@implementation OCAJsonUnarchiver

+ (id)unarchiveObjectOfClass:(Class)class withData:(NSData *)data encoding:(NSStringEncoding)encoding{
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:encoding];
    id jsonResult = [jsonStr JSONValue];
    [jsonStr release];
    return [OCAJsonUnarchiver unarchiveObjectOfClass:class withJSONValue:jsonResult];
}

- (id)initForReadingWithData:(NSData *)data encoding:(NSStringEncoding)encoding{
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:encoding];
    id jsonResult = [jsonStr JSONValue];
    [jsonStr release];
    if (self = [self initForReadingWithJSONValue:jsonResult]) {
    }
    return self;
}

- (id)initForReadingWithJSONValue:(id)jsonValue {
    
    if (self = [super init]) {
        currentObj = jsonValue;
        jsonStack = [[NSMutableArray alloc] initWithCapacity:2];
        [jsonStack addObject:jsonValue];
    }
    return self;
}

+ (id)unarchiveObjectOfClass:(Class)class withJSONValue:(id)jsonValue {
    OCAJsonUnarchiver *tempArchiver = [[[OCAJsonUnarchiver alloc] initForReadingWithJSONValue:jsonValue] autorelease];
    if (class == nil) { // return dictionary or array if class is nil
        return [tempArchiver decodeObject];
    }
    if ([jsonValue isKindOfClass:[NSDictionary class]]) {
        return [tempArchiver decodeCustomObjectOfClass:class];
    } else if ([jsonValue isKindOfClass:[NSArray class]]){
        return [tempArchiver decodeArrayOfClass:class];
    }
    OCALOG(@"Invalid Json Value");
    return nil;
}

- (id)decodeObject {
    return currentObj;
}

- (id)decodeCustomObjectOfClass:(Class)class {
    if ([currentObj isKindOfClass:[NSDictionary class]]) {
        id obj = [[class alloc] autorelease];
        if ([obj conformsToProtocol:@protocol(NSCoding)]) {
            obj = [obj initWithCoder:self];
        } else {
            obj = [obj init];
        }
        return obj;
    }
    return nil;
}

- (id)decodeArrayOfClass:(Class)class {
    if ([currentObj isKindOfClass:[NSArray class]]) {
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:4];
        for (int i = 0; i < [currentObj count]; i++) {
            id obj = [[class alloc] autorelease];
            if ([obj conformsToProtocol:@protocol(NSCoding)]) {
                obj = [obj initWithCoder:self];
            } else {
                obj = [obj init];
            }
            [tempArray addObject:obj];
        }
        return [NSArray arrayWithArray:tempArray];
    }
    return nil;
}

- (id)decodeArrayOfClass:(Class)class forKey:(NSString *)key {
    if ([currentObj isKindOfClass:[NSDictionary class]]) {
        
        id tempObj = [currentObj objectForKey:key];
        
        if ([tempObj isKindOfClass:[NSArray class]]) {
            NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:4];
            for (int i = 0; i < [tempObj count]; i++) {
                id obj = [[class alloc] autorelease];
                if ([obj conformsToProtocol:@protocol(NSCoding)]) {
                    // 入栈
                    currentObj = [tempObj objectAtIndex:i];
                    [jsonStack addObject:currentObj];
                    obj = [obj initWithCoder:self];
                    // 出栈
                    [jsonStack removeLastObject];
                    currentObj = [jsonStack lastObject];
                } else {
                    obj = [obj init];
                }
                [tempArray addObject:obj];
            }
            return [NSArray arrayWithArray:tempArray];
        }
    }
    return nil;
}

- (id)decodeCustomObjectOfClass:(Class)class forKey:(NSString *)key {
    if ([currentObj isKindOfClass:[NSDictionary class]]) {
        id obj = [[class alloc] autorelease];
        if ([obj conformsToProtocol:@protocol(NSCoding)]) {
            id tempObj = [currentObj objectForKey:key];
            if (tempObj == nil) {
                return nil;
            }
            // 入栈
            currentObj = tempObj;
            [jsonStack addObject:currentObj];
            obj = [obj initWithCoder:self];
            // 出栈
            [jsonStack removeLastObject];
            currentObj = [jsonStack lastObject];
        } else {
            obj = [obj init];
        }
        return obj;
    }
    return nil;
}

- (id)decodeObjectForKey:(NSString *)key {
    if ([currentObj isKindOfClass:[NSDictionary class]]) {
        id obj = [currentObj objectForKey:key];
        if (obj == [NSNull null]) {
            return nil;
        }
        return obj;
    }
    return nil;
}

- (BOOL)decodeBoolForKey:(NSString *)key {
    if ([currentObj isKindOfClass:[NSDictionary class]]) {
        return [[currentObj objectForKey:key] boolValue];
    }
    return NO;
}

- (int)decodeIntForKey:(NSString *)key {
    if ([currentObj isKindOfClass:[NSDictionary class]]) {
        if ([[currentObj objectForKey:key] respondsToSelector:@selector(intValue)]) {
            return [[currentObj objectForKey:key] intValue];
        }
        
    }
    return 0;
}

- (int32_t)decodeInt32ForKey:(NSString *)key {
    if ([currentObj isKindOfClass:[NSDictionary class]]) {
        if ([[currentObj objectForKey:key] respondsToSelector:@selector(intValue)]) {
            return [[currentObj objectForKey:key] intValue];
        }
    }
    return 0;
}

- (int64_t)decodeInt64ForKey:(NSString *)key {
    if ([currentObj isKindOfClass:[NSDictionary class]]) {
        if ([[currentObj objectForKey:key] respondsToSelector:@selector(longLongValue)]) {
            return [[currentObj objectForKey:key] longLongValue];
        }
    }
    return 0;
}

- (float)decodeFloatForKey:(NSString *)key {
    if ([currentObj isKindOfClass:[NSDictionary class]]) {
        return [[currentObj objectForKey:key] floatValue];
    }
    return 0;
}

- (double)decodeDoubleForKey:(NSString *)key {
    if ([currentObj isKindOfClass:[NSDictionary class]]) {
        return [[currentObj objectForKey:key] doubleValue];
    }
    return 0;
}

@end
