//
//  PlayerIcon.h
//  HuntAround
//
//  Created by yutao on 12-9-11.
//
//

#import <UIKit/UIKit.h>
#import "UserObj.h"

@interface PlayerIcon : UIView {
    IBOutlet UIImageView *thumbImg;
    IBOutlet UILabel *levelLbl;
    IBOutlet UILabel *nameLbl;
    IBOutlet UILabel *expLbl;
    IBOutlet UILabel *repLbl;
    IBOutlet UILabel *cashLbl;
    IBOutlet UILabel *gemLbl;
    
    IBOutlet UIProgressView *expBar;
    IBOutlet UIProgressView *hpBar;
    IBOutlet UIProgressView *energyBar;
    IBOutlet UIProgressView *staminaBar;
    
}

@property (nonatomic, retain) UserObj *player;

@end
