//
//  AppDelegate.h
//  HuntAround
//
//  Created by yutao on 12-9-7.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "ASIHTTPRequest.h"

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate, ASIHTTPRequestDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
