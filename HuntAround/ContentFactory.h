//
//  ContentFactory.h
//  HuntAround
//
//  Created by yutao on 12-9-10.
//
//

#import <Foundation/Foundation.h>
#import "PanelController.h"
typedef enum {
    PanelIndexBuddy = 1,
    PanelIndexCharacter,
    PanelIndexJob,
    PanelIndexShop,
    PanelIndexInfo,
    PanelIndexArena,
    PanelIndexChat
}PanelIndex;

@interface ContentFactory : NSObject

+ (PanelController *)createPanel:(PanelIndex)index;
@end
