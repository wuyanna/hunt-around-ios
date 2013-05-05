//
//  PoiObj.h
//  HuntAround
//
//  Created by Hou yutao on 9/11/12.
//
//

#import <Foundation/Foundation.h>

@interface PoiObj : NSObject

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) int type;
@property (nonatomic) int level;
@property (nonatomic, retain) NSString *image;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *content;
@property (nonatomic) int actionFlag;

@end
