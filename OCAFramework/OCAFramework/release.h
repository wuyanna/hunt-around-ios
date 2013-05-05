//
//  release.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-2-28.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#ifndef OCAFramework_release_h
#define OCAFramework_release_h

#define release(__POINTER) \
{[__POINTER release];   __POINTER = nil;}

#endif
