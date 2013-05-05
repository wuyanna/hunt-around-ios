//
//  UserService.h
//  HuntAround
//
//  Created by yanna on 12-12-16.
//
//

#import <Foundation/Foundation.h>
#import "UserObj.h"

@interface UserService : NSObject {
    
}

- (UserObj *)userWithId:(NSInteger)uid;

@end
