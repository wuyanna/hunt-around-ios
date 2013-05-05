//
//  ModelBase.m
//  OCAFramework
//
//  Created by Wu Yanna on 12-3-6.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import "ModelBase.h"

@implementation ModelBase

@synthesize delegate;

- (id)init {
    self = [super init];
    if (self) {
        dataDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}
- (void)setValue:(id)value forKey:(NSString *)key {
    [dataDictionary setValue:value forKey:key];
}
- (id)valueForKey:(NSString *)key {
    return [dataDictionary valueForKey:key];
}

#pragma mark - Data Channel Protocol

- (void)dataChannel:(DataChannel *)dataChannel didGetResult:(id)result {
    
}

@end
