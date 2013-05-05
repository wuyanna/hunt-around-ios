//
//  ModelBase.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-3-6.
//  Copyright (c) 2012年 DP. All rights reserved.
//
// 待完善，此版不用
#import <Foundation/Foundation.h>
#import "DataChannel.h"


typedef enum {
    DataSourceTypeNet = 0,
    DataSourceTypeCache,
    DataSourceTypeMem,
}DataSourceType;

@protocol ModelDataDelegate;
@interface ModelBase : NSObject <DataChannelProtocol>{
@protected
    NSMutableDictionary*    dataDictionary;
    id<ModelDataDelegate>   delegate;
}

@property (nonatomic, assign) id<ModelDataDelegate> delegate;

- (void)setValue:(id)value forKey:(NSString *)key;
- (id)valueForKey:(NSString *)key;

@end

@protocol ModelDataDelegate <NSObject>

@optional

- (void)model:(ModelBase *)model dataUpdated:(id)result sourceType:(DataSourceType)sourceType;

- (void)model:(ModelBase *)model dataUpdateFailedWithMessage:(NSString *)msg;
@end