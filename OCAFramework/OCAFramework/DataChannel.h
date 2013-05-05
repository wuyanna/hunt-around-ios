//
//  DataChannel.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-2-28.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DataChannelProtocol;
@interface DataChannel : NSObject {
    NSURLConnection*        _connection;
    NSMutableString*        _url;
    NSInteger               _statusCode;
    NSMutableData*          _buf;
    NSInteger               _bufLen;
    NSError*                _error;
    NSInteger               _protocol;
    NSThread*               _mainThread;
    id                      _result;
    id<DataChannelProtocol> _delegate;
    NSString*               _httpDomain;
    NSString*               _api;
    NSData*                 _postData;
    NSString                *_paramStr;
}

@property (nonatomic, assign) id        result;
@property (nonatomic, assign) id        delegate;
@property (nonatomic, retain) NSString* httpDomain;
@property (nonatomic, retain) NSString* api;
@property (nonatomic, retain) NSData*   postData;

+ (void)setHostDomain:(NSString *)aUrl;
+ (void)setAPIDomain:(NSString *)aUrl;
+ (NSString *)hostDomain;
+ (NSString *)APIDomain;
- (id)initWithDelegate:(id)delegate;
- (void)getRequest:(NSString*)api;
- (void)postRequest:(NSString*)api;
- (void)requestFile:(NSString*)fileName;
// 设置参数键值对，最终会将键值对转换为NSData格式存入postData中。
// 键在前，值在后，最后的结尾应该为nil
- (BOOL)setParams:(NSString *)first, ...;
- (void)parseData:(NSData *)buf;
@end

@protocol DataChannelProtocol <NSObject>

@optional
- (void)dataChannel:(DataChannel*)dataChannel didGetResult:(id)result;
- (void)dataChannel:(DataChannel*)dataChannel didFinishLoadingData:(NSData*)data;
- (void)dataChannel:(DataChannel*)dataChannel didRecvBytes:(NSInteger)recvedBytes totalBytes:(NSInteger)totalBytes;
- (void)dataChannel:(DataChannel*)dataChannel didRecvResponseWithContentLength:(NSInteger)dataLength;
@end