//
//  UserObj.h
//  HuntAround
//
//  Created by yanna on 12-12-16.
//
//

#import <Foundation/Foundation.h>

@interface UserObj : NSObject

@property (nonatomic) NSInteger userid;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *pass;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *lastLoginDate;
@property (nonatomic, retain) NSString *registerDate;
@property (nonatomic, retain) NSString *level;
@property (nonatomic) NSInteger exp;
@property (nonatomic) NSInteger rep; //声望值，用途：购买限制、打折 高等级打低等级会扣声望值
@property (nonatomic) NSInteger cash;
@property (nonatomic) NSInteger gem; // 钻石,用钱买的.
@property (nonatomic) NSInteger hp;
@property (nonatomic) NSInteger energy; // 精力值，做任务消耗精力值
@property (nonatomic) NSInteger stamina; // 斗志，对战消耗斗志
@property (nonatomic) NSInteger att;
@property (nonatomic) NSInteger def;
@property (nonatomic) NSInteger continuousLogin; // 连续登陆天数

@end
