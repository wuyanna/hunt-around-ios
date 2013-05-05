//
//  core.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-3-4.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#ifndef OCAFramework_core_h
#define OCAFramework_core_h

#import "release.h"
#import "ModelBase.h"
#import "OCAJsonUnarchiver.h"

#define OCALOG(format, ...) \
NSLog(@"[%s %s LINE(%d)] %@", __FILE__, __FUNCTION__, __LINE__, [NSString stringWithFormat:format, ## __VA_ARGS__])

#endif
