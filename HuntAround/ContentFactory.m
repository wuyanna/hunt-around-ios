//
//  ContentFactory.m
//  HuntAround
//
//  Created by yutao on 12-9-10.
//
//

#import "ContentFactory.h"
#import "BuddyController.h"
#import "CharacterController.h"
#import "InfoController.h"
#import "ChatController.h"
#import "ArenaController.h"
#import "JobController.h"
#import "ShopController.h"

@implementation ContentFactory

+ (PanelController *)createPanel:(PanelIndex)index {
    switch (index) {
        case PanelIndexBuddy:
            return [[[BuddyController alloc]init] autorelease];
            break;
        case PanelIndexCharacter:
            return [[[CharacterController alloc]init] autorelease];
            break;
        case PanelIndexArena:
            return [[[ArenaController alloc]init] autorelease];
            break;
        case PanelIndexInfo:
            return [[[InfoController alloc]init] autorelease];
            break;
        case PanelIndexJob:
            return [[[JobController alloc]init]autorelease];
            break;
        case PanelIndexShop:
            return [[[ShopController alloc]init]autorelease];
            break;
        case PanelIndexChat:
            return [[[ChatController alloc]init]autorelease];
            break;
        default:
            return nil;
            break;
    }
    return nil;
}
@end
