//
//  DataChannel.m
//  OCAFramework
//
//  Created by Wu Yanna on 12-2-28.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import "DataChannel.h"
#import "OCAUtils.h"

#define NETWORK_TIMEOUT 120.0

static NSString* kHostDomain = nil;
static NSString* kAPIDomain = nil;
/* 使用时打开
static OCAByteCache *permanentCache;
*/
@interface DataChannel (Private)
- (void)requestDidComplete;
- (void)request:(NSString*)api method:(NSString*)method;
@end

@implementation DataChannel

@synthesize result      =       _result;
@synthesize delegate    =       _delegate;
@synthesize httpDomain  =       _httpDomain;
@synthesize postData    =       _postData;
@synthesize api         =       _api;

- (id)initWithDelegate:(id)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}
#pragma mark - NSURLConnection Delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	
	[_buf appendData:data];
    if ([_delegate respondsToSelector:@selector(dataChannel:didRecvBytes:totalBytes:)]) {
        [_delegate dataChannel:self didRecvBytes:_buf.length totalBytes:_bufLen];
    }
	
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
    NSDictionary* head = [resp allHeaderFields];
	//NSLog(@"response:\n%@",[resp allHeaderFields]);
    _bufLen = [[head objectForKey:@"Content-Length"] intValue];
    [_buf release];
    _buf = [[NSMutableData alloc] initWithCapacity:_bufLen];
    if ([_delegate respondsToSelector:@selector(dataChannel:didRecvResponseWithContentLength:)]) {
        [_delegate dataChannel:self didRecvResponseWithContentLength:_bufLen];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"CONNECTION FAILED:%@",error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if ([_delegate respondsToSelector:@selector(dataChannel:didFinishLoadingData:)]) {
        [_delegate performSelector:@selector(dataChannel:didFinishLoadingData:) withObject:self withObject:_buf];
    }

    [self requestDidComplete];
    
}

- (void)parseData:(NSData *)buf {
    
}

- (void)requestDidComplete {
    [self parseData:_buf];
    
    if ([_delegate respondsToSelector:@selector(dataChannel:didGetResult:)]) {
        [_delegate dataChannel:self didGetResult:_result];
    }

}

- (void)getRequest:(NSString*)api {
    [self request:api method:@"GET"];
}

- (void)postRequest:(NSString*)api {
    [self request:api method:@"POST"];
}

- (BOOL)setParams:(NSString *)first, ... {
	if(first) {
		NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"%@=", first];
		int i = 1;
		va_list ap;
		va_start(ap, first);
		NSString *s;
		while((s = va_arg(ap, NSString *))) {
			if(i % 2) {
				[str appendString:[s stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
			} else {
				[str appendFormat:@"&%@=", s];
			}
			i++;
		}
		va_end(ap);
        _paramStr = [str copy];
		self.postData = [str dataUsingEncoding:NSUTF8StringEncoding];
		[str release];
        return YES;
	} else {
		self.postData = nil;
        return NO;
	}
}

- (void)requestFile:(NSString*)filePathName {
    NSString* urlstr = [NSString stringWithFormat:@"%@%@",[DataChannel hostDomain],filePathName];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSLog(@"FILE REQUEST URL:%@",urlstr);
    if (!url) {
		NSString *reason = [NSString stringWithFormat:
							@"Could not create URL from string %@", urlstr];
		NSLog(@"Error:%@",reason);
		return;
	}
	//create the request
	NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url 
													   cachePolicy:NSURLRequestUseProtocolCachePolicy 
												   timeoutInterval:NETWORK_TIMEOUT];
    
	if (!req) {
		NSString *reason = [NSString stringWithFormat:
							@"Could not create URL request from string %@", _url];
		NSLog(@"Error:%@",reason);
		return;
	}
	//create the connection
	_connection = [[NSURLConnection alloc] initWithRequest:req delegate:self];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)request:(NSString*)api method:(NSString*)method {
	//NSURL *url = [NSURL URLWithString:_url];
    self.api = api;
    NSString* urlstr = [NSString stringWithFormat:@"%@/%@?%@",[DataChannel APIDomain],api,_paramStr];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSLog(@"%@ REQUEST URL:%@",method,urlstr);
	if (!url) {
		NSString *reason = [NSString stringWithFormat:
							@"Could not create URL from string %@", urlstr];
		NSLog(@"Error:%@",reason);
		return;
	}
	//create the request
	NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url 
													   cachePolicy:NSURLRequestUseProtocolCachePolicy 
												   timeoutInterval:NETWORK_TIMEOUT];
	/*[req addValue:@"Mozilla/5.0" forHTTPHeaderField:@"User-Agent"];
     [req setValue:@"application/xml,application/xhtml+xml,text/html" forHTTPHeaderField:@"Accept"];
     [req setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];*/
    [req setHTTPMethod:method];
    if ([method isEqualToString:@"POST"]) {
        NSString* aStr;
        aStr = [[NSString alloc] initWithData:self.postData encoding:NSUTF8StringEncoding];
        NSLog(@"POST DATA:%@",aStr);
        [aStr release];
        [req setHTTPBody:self.postData];
    }
    
	if (!req) {
		NSString *reason = [NSString stringWithFormat:
							@"Could not create URL request from string %@", _url];
		NSLog(@"Error:%@",reason);
		return;
	}
	//create the connection
	_connection = [[NSURLConnection alloc] initWithRequest:req delegate:self];
	//NSLog(@"get http header:%@",[req allHTTPHeaderFields]);
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

+ (void)setHostDomain:(NSString *)aUrl {
    if (kHostDomain != aUrl) {
        [kHostDomain release];
        kHostDomain = [aUrl retain];
    }
}

+ (NSString *)hostDomain {
    if(kHostDomain)
		return kHostDomain;
	return nil;
}

+ (void)setAPIDomain:(NSString *)aUrl {
    if (kAPIDomain != aUrl) {
        [kAPIDomain release];
        kAPIDomain = [aUrl retain];
    }
}

+ (NSString *)APIDomain {
    if(kAPIDomain)
		return kAPIDomain;
	return nil;
}
@end

